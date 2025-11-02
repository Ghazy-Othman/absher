<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    public function run()
    {
        $vendor1 = User::where('email', 'vendor1@app.com')->first();
        $vendor2 = User::where('email', 'vendor2@app.com')->first();

        //
        Product::create([
            'name' => 'Vendor1 Product A',
            'price' => 10.5,
            'description' => 'Product A from Vendor 1',
            'vendor_id' => $vendor1->id,
        ]);

        Product::create([
            'name' => 'Vendor1 Product B',
            'price' => 15.0,
            'description' => 'Product B from Vendor 1',
            'vendor_id' => $vendor1->id,
        ]);

        //
        Product::create([
            'name' => 'Vendor2 Product A',
            'price' => 8.0,
            'description' => 'Product A from Vendor 2',
            'vendor_id' => $vendor2->id,
        ]);

        Product::create([
            'name' => 'Vendor2 Product B',
            'price' => 20.0,
            'description' => 'Product B from Vendor 2',
            'vendor_id' => $vendor2->id,
        ]);
    }
}
