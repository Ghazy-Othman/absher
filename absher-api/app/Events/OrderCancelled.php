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

class OrderCancelled implements ShouldBroadcastNow
{
    use SerializesModels;

    public Order $order;

    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    public function broadcastOn(): array
    {
        $channels = [
            new PrivateChannel('vendor.' . $this->order->vendor_id),
            new PrivateChannel('customer.' . $this->order->customer_id),
            new PrivateChannel('order.' . $this->order->id),
        ];

        if ($this->order->deliveryman_id) {
            $channels[] = new PrivateChannel('delivery.' . $this->order->deliveryman_id);
        }

        return $channels;
    }

    public function broadcastAs(): string
    {
        return 'order.cancelled';
    }

    public function broadcastWith(): array
    {
        return [
            'order' => $this->order->loadMissing('customer:id,name', 'vendor:id,name'),
            'cancelled_at' => now()->toDateTimeString(),
        ];
    }
}
