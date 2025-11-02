<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    ///
    use HasFactory;

    ///
    protected $fillable = [
        'name',
        'price',
        'description',
        'vendor_id',
    ];

    ///
    public function vendor()
    {
        return $this->belongsTo(User::class, 'vendor_id');
    }
}
