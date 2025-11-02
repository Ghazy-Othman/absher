<?php

namespace App\Http\Controllers\API\V1;

use App\Events\OrderPlaced;
use App\Http\Controllers\Controller;
use App\Http\Responses\CustomResponse;
use App\Models\Cart;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CheckoutController extends Controller
{
    //
    public function checkoutCart(Request $request, $cartId)
    {
        try {

            $cart = Cart::where('id', $cartId)
                ->where('user_id', auth('api')->user()->id)
                ->where('status', 'pending')
                ->first();

            if (!$cart) {
                return CustomResponse::notFound("Cart not found on not in pending status.");
            }

            DB::beginTransaction();

            //
            $cart = Cart::with('items.product')->findOrFail($cartId);

            //
            $total = 0;
            foreach ($cart->items as $item) {
                $unitPrice = (int) $item->product->price;
                $qty = (int) $item->quantity;
                $line = $unitPrice * $qty;
                $total += $line;
            }
            //
            $order = Order::create([
                'customer_id'     => $cart->user_id,
                'vendor_id'       => $cart->vendor_id,
                'deliveryman_id'  => null,
                //
                'pickup_address'  => $cart->vendor->address,
                'delivery_address' => $request->delivery_address,
                //
                'status'          => 'pending',
                'notes'           => null,
                //
                'cart_id' => $cart->id,
                'total' => $total,
            ]);


            //
            $cart->update(['status' => 'ordered']);

            DB::commit();

            //
            event(new OrderPlaced($order));

            return CustomResponse::created($order);
        } catch (\Throwable $e) {
            DB::rollBack();
            return CustomResponse::serverError($e->getMessage());
        }
    }
}
