<?php

namespace App\Listeners;

use App\Events\OrderPublished;
use App\Models\User;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class NotifyDeliveryMenOfNewOrder
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(): void
    {
        //
        // $deliveryMen = User::role('delivery')->get();

        // foreach ($deliveryMen as $deliveryMan) {
        //     ///TODO : Notify all delivery mens
        // }
    }
}
