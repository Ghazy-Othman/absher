<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    ///
    use HasFactory, Notifiable, HasRoles;

    ///
    protected $fillable = [
        'name',
        'email',
        'password',
        'avatar',
        'address',
        'phone',
    ];

    ///
    protected $hidden = [
        'password',
        'remember_token',
    ];

    ///
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    ///
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    ///
    public function getJWTCustomClaims()
    {
        return [
            'id' => $this->id, 
            'email' => $this->email,
        ];
    }

    ///
    public function customerOrders()
    {
        return $this->hasMany(Order::class, 'customer_id');
    }

    ///
    public function vendorOrders()
    {
        return $this->hasMany(Order::class, 'vendor_id');
    }

    ///
    public function deliveries()
    {
        return $this->hasMany(Order::class, 'deliveryman_id');
    }

    //
    public function deliveryRequests()
    {
        return $this->hasMany(DeliveryRequest::class, 'delivery_man_id');
    }
}
