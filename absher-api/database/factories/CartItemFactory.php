<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\CartItem>
 */
class CartItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            //
            'cart_id' => null,
            'product_id' => null,
            'quantity' => $qty = $this->faker->numberBetween(1, 5),
            'total_price' => 0, // calculate after product is known
        ];
    }
}
