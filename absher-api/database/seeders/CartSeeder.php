<?php

namespace Database\Seeders;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CartSeeder extends Seeder
{
    public function run()
    {
        $customer = User::where('email', 'customer@app.com')->first();
        $vendor1 = User::where('email', 'vendor1@app.com')->first();
        $vendor2 = User::where('email', 'vendor2@app.com')->first();

        //
        $productsVendor1 = Product::where('vendor_id', $vendor1->id)->get();
        $productsVendor2 = Product::where('vendor_id', $vendor2->id)->get();

        //
        $cart1 = Cart::create([
            'user_id' => $customer->id,
            'vendor_id' => $vendor1->id,
            'status' => 'pending',
        ]);

        foreach ($productsVendor1 as $product) {
            CartItem::create([
                'cart_id' => $cart1->id,
                'product_id' => $product->id,
                'quantity' => 2,
                'total_price' => $product->price * 2,
            ]);
        }

        //
        $cart2 = Cart::create([
            'user_id' => $customer->id,
            'vendor_id' => $vendor2->id,
            'status' => 'pending',
        ]);

        foreach ($productsVendor2 as $product) {
            CartItem::create([
                'cart_id' => $cart2->id,
                'product_id' => $product->id,
                'quantity' => 1,
                'total_price' => $product->price,
            ]);
        }
    }
}
