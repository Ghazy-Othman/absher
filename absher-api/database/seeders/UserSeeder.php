<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run()
    {
        //
        $customer = User::create([
            'name' => 'Customer User',
            'email' => 'customer@app.com',
            'password' => bcrypt('customer'),
        ]);
        $customer->assignRole('customer');

        //
        $vendor1 = User::create([
            'name' => 'Vendor One',
            'email' => 'vendor1@app.com',
            'password' => bcrypt('vendor'),
        ]);
        $vendor1->assignRole('vendor');

        $vendor2 = User::create([
            'name' => 'Vendor Two',
            'email' => 'vendor2@app.com',
            'password' => bcrypt('vendor'),
        ]);
        $vendor2->assignRole('vendor');

        //
        $deliveryMan = User::create([
            'name' => 'Delivery Man',
            'email' => 'delivery@app.com',
            'password' => bcrypt('delivery'),
        ]);
        $deliveryMan->assignRole('delivery');
    }
}
