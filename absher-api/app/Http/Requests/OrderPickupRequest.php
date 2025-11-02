<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderPickupRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth('api')->check() && auth('api')->user()->hasRole('delivery');
    }

    public function rules(): array
    {
        return [
            'order_id' => 'required|exists:orders,id',
        ];
    }
}
