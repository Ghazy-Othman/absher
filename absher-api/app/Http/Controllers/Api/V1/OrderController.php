<?php

namespace App\Http\Controllers\Api\V1;

use App\Events\OrderCancelled;
use App\Models\Order;
use App\Http\Controllers\Controller;
use App\Http\Requests\OrderCancelRequest;
use App\Http\Responses\CustomResponse;
use App\Models\Cart;
use App\OrderStatus;

class OrderController extends Controller
{
    //
    public function cancel(OrderCancelRequest $request)
    {
        try {
            $user = auth('api')->user();

            $order = Order::where('id', $request->order_id)
                ->where('customer_id', $user->id)
                ->firstOrFail();

            if (!in_array($order->status, [OrderStatus::Pending, OrderStatus::Published, OrderStatus::Assigned])) {
                return CustomResponse::badRequest('Order cannot be canceled at this stage.');
            }

            $order->status = OrderStatus::Cancelled;
            $order->save();


            event(new OrderCancelled($order));

            return CustomResponse::ok($order);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to cancel the order.');
        }
    }

    //
    public function show($order_id)
    {
        $order = Order::find($order_id);
        return CustomResponse::ok([
            'order' => $order,
            'products' => Cart::where('user_id', $order->customer_id)->first()->items()->get()
        ]);
    }
}
