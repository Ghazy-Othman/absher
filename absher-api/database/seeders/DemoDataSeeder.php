<?php

namespace Database\Seeders;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DemoDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Vendor
        $vendor = User::factory()->create([
            'name' => 'Big Vendor',
            'email' => 'bigvendor@example.com',
            'password' => bcrypt('vendor'),
        ]);
        $vendor->assignRole('vendor');

        // Create 35 products for vendor (prices in cents)
        $products = Product::factory(35)->create(['vendor_id' => $vendor->id]);

        // Create 10 customers
        $customers = User::factory(10)->create()->each(function ($u) {
            $u->assignRole('customer');
        });

        foreach ($customers as $customer) {
            // create cart for this vendor
            $cart = Cart::factory()->create([
                'user_id' => $customer->id,
                'vendor_id' => $vendor->id,
                'status' => 'pending',
            ]);

            // pick between 3 and 8 random products for this cart
            $selected = $products->random(rand(3, 8));

            foreach ($selected as $p) {
                $qty = rand(1, 5);
                CartItem::create([
                    'cart_id' => $cart->id,
                    'product_id' => $p->id,
                    'quantity' => $qty,
                    'total_price' => $p->price * $qty, // integer cents
                ]);
            }
        }

        // Create 10-20 orders with pending or published
        $ordersCount = rand(10, 20);
        $allCarts = Cart::where('vendor_id', $vendor->id)->get();

        for ($i = 0; $i < $ordersCount; $i++) {
            $cart = $allCarts->random();
            $customer = $cart->user;

            // total from cart items (integers)
            $total = $cart->items->sum(fn($it) => $it->total_price);

            $status = rand(0, 1) ? 'pending' : 'published';
            $deliveryCost = ($status === 'published') ? rand(200, 5000) : null; // in cents

            $order = Order::create([
                'customer_id' => $customer->id,
                'vendor_id' => $vendor->id,
                'cart_id' => $cart->id,
                'status' => $status,
                'pickup_address' => $vendor->address,
                'delivery_address' => $customer->address,
                'total' => $total,
                'delivery_cost' => $deliveryCost,
            ]);

            // copy items -> packages if needed (omit price)
            foreach ($cart->items as $item) {
                $order->packages()->create([
                    'description' => $item->product->name,
                    'weight' => $item->product->weight ?? null,
                    'quantity' => $item->quantity,
                ]);
            }
        }
    }
}
