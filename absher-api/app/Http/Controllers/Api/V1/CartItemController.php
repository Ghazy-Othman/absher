<?php

namespace App\Http\Controllers\API\V1;

use App\CartStatus;
use App\Models\CartItem;
use App\Http\Requests\StoreCartItemRequest;
use App\Http\Requests\UpdateCartItemRequest;
use App\Http\Controllers\Controller;
use App\Http\Responses\CustomResponse;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class CartItemController extends Controller
{
    ///
    public function addItem(StoreCartItemRequest $request)
    {
        try {
            //
            $product = Product::findOrFail($request->product_id);

            // Get the cart for a specific user and vendor
            // If not exists, create it
            $cart = Cart::firstOrCreate([
                'user_id' => auth('api')->id(),
                'vendor_id' => $product->vendor_id,
                'status' => CartStatus::Pending
            ]);

            $total   = $product->price * $request->quantity;

            $item = CartItem::create([
                'cart_id'     => $cart->id,
                'product_id'  => $product->id,
                'quantity'    => $request->quantity,
                'total_price' => $total,
            ]);

            return CustomResponse::created($item);
        } catch (\Throwable $e) {
            return CustomResponse::serverError($e->getMessage());
        }
    }

    ///
    public function updateItem(UpdateCartItemRequest $request, $itemId)
    {
        try {

            $item = CartItem::findOrFail($itemId);

            $product = $item->product;
            $item->update([
                'quantity'    => $request->quantity,
                'total_price' => $product->price * $request->quantity,
            ]);

            return CustomResponse::ok($item);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to update item.');
        }
    }

    ///
    public function removeItem($itemId)
    {
        try {

            $item = CartItem::findOrFail($itemId);

            $item->delete();
            return CustomResponse::noContent();
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to remove item.');
        }
    }
}
