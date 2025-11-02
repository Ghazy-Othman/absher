<?php

namespace App\Events;

use App\Models\Order;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class OrderPickedUp implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;


    public Order $order;

    //
    public function __construct(Order $order)
    {
        //
        $this->order = $order;
    }

    //
    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('vendor.' . $this->order->vendor_id),
            new PrivateChannel('customer.' . $this->order->customer_id),
            new PrivateChannel('delivery.' . $this->order->deliveryman_id),
            new PrivateChannel('order.' . $this->order->id),
        ];
    }

    //
    public function broadcastAs(): string
    {
        return 'order.picked_up';
    }

    //
    public function broadcastWith(): array
    {
        return [
            'order' => $this->order->loadMissing('customer:id,name', 'vendor:id,name'),
            'picked_at' => now()->toDateTimeString(),
        ];
    }
}
