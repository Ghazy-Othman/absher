<?php

namespace App\Events;

use App\Models\DeliveryRequest;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class DeliveryRequested implements ShouldBroadcastNow
{
    use SerializesModels;

    public DeliveryRequest $deliveryRequest;

    public function __construct(DeliveryRequest $deliveryRequest)
    {
        $this->deliveryRequest = $deliveryRequest;
    }

    public function broadcastOn(): PrivateChannel
    {
        // notify vendor for that order
        return new PrivateChannel('vendor.' . $this->deliveryRequest->order->vendor_id);
    }

    public function broadcastAs(): string
    {
        return 'delivery.requested';
    }

    public function broadcastWith(): array
    {
        return [
            'delivery_request' => $this->deliveryRequest->loadMissing('deliveryMan:id,name', 'order:id,customer_id,vendor_id'),
        ];
    }
}
