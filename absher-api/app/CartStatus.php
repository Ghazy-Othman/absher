<?php

namespace App;

enum CartStatus: String
{
    case Pending = 'pending';
    case ordered = 'ordered';
}
