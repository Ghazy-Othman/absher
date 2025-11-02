<?php

namespace App\Http\Controllers\API\V1;

use App\CartStatus;
use App\Models\Cart;
use App\Http\Requests\StoreCartRequest;
use App\Http\Requests\UpdateCartRequest;
use App\Http\Controllers\Controller;
use App\Http\Responses\CustomResponse;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    ///
    public function index()
    {
        try {
            $carts = Cart::with('items.product')
                ->where('user_id', Auth::id())
                ->get();

            return CustomResponse::ok($carts);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to fetch carts.');
        }
    }

    ///
    public function store(StoreCartRequest $request)
    {
        try {
            $cart = Cart::create([
                'user_id'   => Auth::id(),
                'vendor_id' => $request->vendor_id,
                'status'    => CartStatus::Pending,
            ]);
            return CustomResponse::created($cart);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to create cart.');
        }
    }

    ///
    public function show($id)
    {
        try {
            $cart = Cart::with('items.product')
                ->where('user_id', Auth::id())
                ->findOrFail($id);

            return CustomResponse::ok($cart);
        } catch (\Throwable $e) {
            return CustomResponse::notFound('Cart not found.');
        }
    }

    ///
    public function destroy($id)
    {
        try {
            $cart = Cart::where('user_id', Auth::id())
                ->where('status', CartStatus::Pending)
                ->findOrFail($id);
            $cart->delete();
            return CustomResponse::noContent();
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to delete cart.');
        }
    }
}
