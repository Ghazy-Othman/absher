<?php

namespace App\Models;

use App\OrderStatus;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    ///
    use HasFactory;

    ///
    protected $fillable = [
        'customer_id',
        'vendor_id',
        'deliveryman_id',
        'pickup_address',
        'delivery_address',
        'status',
        'scheduled_at',
        'delivered_at',
        'notes',
        'total',
        'cart_id',
        'delivery_cost'
    ];


    ///
    protected $casts = [
        'scheduled_at' => 'datetime',
        'delivered_at' => 'datetime',
        // 'status' => OrderStatus::class
    ];

    ///
    public function cart()
    {
        return $this->belongsTo(Cart::class);
    }

    ///
    public function customer()
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    ///
    public function vendor()
    {
        return $this->belongsTo(User::class, 'vendor_id');
    }

    ///
    public function deliveryman()
    {
        return $this->belongsTo(User::class, 'deliveryman_id');
    }

    //
    public function deliveryRequests()
    {
        return $this->hasMany(DeliveryRequest::class);
    }

    public function approvedDeliveryRequest()
    {
        return $this->hasOne(DeliveryRequest::class)->where('status', 'approved');
    }
}
