<?php

namespace App;

enum OrderStatus: String
{
    //
    case Pending = 'pending';
    case Published = 'published';
    case Assigned = 'assigned';
    case PickedUp = 'picked_up';
    case Delivered = 'delivered';
    case Cancelled = 'cancelled';
}
