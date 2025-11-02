<?php

namespace Database\Seeders;

use App\Models\Cart;
use App\Models\Order;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OrderSeeder extends Seeder
{
    public function run()
    {
        $carts = Cart::all();

        foreach ($carts as $cart) {
            Order::create([
                'customer_id' => $cart->user_id,
                'vendor_id' => $cart->vendor_id,
                'cart_id' => $cart->id,
                'status' => 'pending',
                'delivery_address' => '123 Demo Street',
            ]);

            $cart->update(['status' => 'ordered']);
        }
    }
}
