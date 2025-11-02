<?php

namespace App\Models;

use App\CartStatus;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    ///
    use HasFactory;

    ///
    protected $fillable = [
        'user_id',
        'vendor_id',
        'status',
    ];

    ///
    protected $casts = [
        'status' => CartStatus::class,
    ];

    ///
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    ///
    public function vendor()
    {
        return $this->belongsTo(User::class, 'vendor_id');
    }

    ///
    public function items()
    {
        return $this->hasMany(CartItem::class);
    }
}
