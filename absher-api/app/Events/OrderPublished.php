<?php

namespace App\Events;

use App\Models\Order;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class OrderPublished implements ShouldBroadcastNow
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
    public function broadcastOn(): PrivateChannel
    {
        return new PrivateChannel('delivery');
    }

    //
    public function broadcastAs(): string
    {
        return 'order.published';
    }

    public function broadcastWith(): array
    {
        return [
            'order' => $this->order->loadMissing('customer:id,name', 'cart.items.product'),
        ];
    }
}
