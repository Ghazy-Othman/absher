<?php

namespace App\Http\Controllers\API\V1;

use App\Events\OrderPublished;
use App\Http\Controllers\Controller;
use App\Http\Responses\CustomResponse;
use App\Models\Order;
use App\Models\User;
use App\OrderStatus;
use Illuminate\Http\Request;

class VendorOrderController extends Controller
{

    //
    public function ordersToPublish($vendor_id)
    {
        try {
            $user = User::find($vendor_id);
            $orders = $user->vendorOrders;
            return CustomResponse::ok(['orders' => $orders]);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to publish order.');
        }
    }

    //
    public function publishOrder(Request $request,  $orderId)
    {
        try {
            $vendorId = auth('api')->id();

            $order = Order::where('id', $orderId)
                ->where('vendor_id', $vendorId)
                ->where('status', OrderStatus::Pending)
                ->firstOrFail();

            $order->delivery_cost = (int) $request->input('delivery_cost');
            $order->status = OrderStatus::Published;
            $order->save();


            event(new OrderPublished($order));

            return CustomResponse::ok($order);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to publish order.');
        }
    }
}
