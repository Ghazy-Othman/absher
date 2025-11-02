<?php

namespace App\Http\Controllers\API\V1;

use App\Events\DeliveryRequested;
use App\Events\OrderAssigned;
use App\Events\OrderDelivered;
use App\Events\OrderPickedUp;
use App\Http\Controllers\Controller;
use App\Http\Requests\DeliveryRequestStoreRequest;
use App\Http\Requests\OrderDeliveredRequest;
use App\Http\Requests\OrderPickupRequest;
use App\Http\Requests\UpdateDeliveryRequestStatusRequest;
use App\Http\Responses\CustomResponse;
use App\Models\DeliveryRequest;
use App\Models\Order;
use App\OrderStatus;
use Illuminate\Http\Request;

class DeliveryRequestController extends Controller
{
    //
    public function store(DeliveryRequestStoreRequest $request)
    {
        try {
            $deliveryMan = auth('api')->user();

            $order = Order::where('id', $request->order_id)
                ->where('status', OrderStatus::Published)
                ->firstOrFail();


            ///
            $exists = DeliveryRequest::where('order_id', $order->id)
                ->where('delivery_man_id', $deliveryMan->id)
                ->first();

            if ($exists) {

                if ($exists->status === 'pending') {
                    return CustomResponse::badRequest('You already requested this order.');
                }

                if ($exists->status === 'approved') {
                    return CustomResponse::badRequest('You already get this order.');
                }
                $exists->status = 'pending';
                $exists->save();
                return CustomResponse::ok($exists);
            }

            $deliveryRequest = DeliveryRequest::create([
                'order_id' => $order->id,
                'delivery_man_id' => $deliveryMan->id,
                'status' => 'pending',
            ]);

            event(new DeliveryRequested($deliveryRequest));

            return CustomResponse::created($deliveryRequest);
        } catch (\Throwable $e) {
            return CustomResponse::serverError($e->getMessage());
        }
    }


    //
    public function updateStatus(UpdateDeliveryRequestStatusRequest $request, $id)
    {
        try {
            $vendor = auth('api')->user();

            $deliveryRequest = DeliveryRequest::with('order')
                ->where('id', $id)
                ->firstOrFail();

            $order = $deliveryRequest->order;

            //
            if ($order->vendor_id !== $vendor->id) {
                return CustomResponse::unauthorized('You do not own this order.');
            }

            if ($request->status === 'approved') {
                //
                $approvedExists = DeliveryRequest::where('order_id', $order->id)
                    ->where('status', 'approved')
                    ->exists();

                if ($approvedExists) {
                    return CustomResponse::badRequest('Order already has an approved delivery.');
                }

                //
                $deliveryRequest->status = 'approved';
                $deliveryRequest->save();

                //
                $order->status = OrderStatus::Assigned;
                $order->save();

                event(new OrderAssigned($order));
            } else {
                $deliveryRequest->status = 'declined';
                $deliveryRequest->save();
            }

            return CustomResponse::ok($deliveryRequest);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to update delivery request.');
        }
    }

    //
    public function markAsPickedUp(OrderPickupRequest $request)
    {
        try {

            $deliveryMan = auth('api')->user();

            $order = Order::with('approvedDeliveryRequest')->findOrFail($request->order_id);

            // 
            if ($order->status !== OrderStatus::Assigned) {
                return CustomResponse::badRequest('Order is not assigned yet.');
            }

            //
            $approvedRequest = $order->approvedDeliveryRequest;
            if (!$approvedRequest || $approvedRequest->delivery_man_id !== $deliveryMan->id) {
                return CustomResponse::unauthorized('You are not assigned to this order.');
            }

            //
            $order->status = OrderStatus::PickedUp;
            $order->save();

            event(new OrderPickedUp($order));

            return CustomResponse::ok($order);
        } catch (\Throwable $e) {
            return CustomResponse::serverError($e->getMessage());
        }
    }

    //
    public function markAsDelivered(OrderDeliveredRequest $request)
    {
        try {
            $deliveryMan = auth('api')->user();

            $order = Order::with('approvedDeliveryRequest')->findOrFail($request->order_id);

            if ($order->status !== OrderStatus::PickedUp) {
                return CustomResponse::badRequest('Order is not picked up yet.');
            }

            $approvedRequest = $order->approvedDeliveryRequest;
            if (!$approvedRequest || $approvedRequest->delivery_man_id !== $deliveryMan->id) {
                return CustomResponse::unauthorized('You are not assigned to this order.');
            }

            $order->status = OrderStatus::Delivered;
            $order->save();

            event(new OrderDelivered($order));

            return CustomResponse::ok($order);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to mark order as delivered.');
        }
    }
}
