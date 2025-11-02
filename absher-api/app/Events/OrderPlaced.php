<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class OrderPlaced implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;


    public $order;

    //
    public function __construct($order)
    {
        $this->order = $order;
    }

    //
    public function broadcastOn(): Channel
    {
        return new PrivateChannel('vendor' . $this->order->vendor_id);
    }

    public function broadcastAs(): string
    {
        return "order.placed";
    }

    //
    public function broadcastWith(): array
    {
        return [
            'order' => $this->order->loadMissing('customer:id,name', 'cart.items.product'),
        ];
    }
}
