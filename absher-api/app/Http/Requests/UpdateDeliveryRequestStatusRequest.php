<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateDeliveryRequestStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth('api')->check() && auth('api')->user()->hasRole('vendor');
    }

    public function rules(): array
    {
        return [
            'status' => 'required|in:approved,declined',
        ];
    }
}
