<?php

use App\Events\OrderPlaced;
use App\Http\Controllers\API\V1\AuthController;
use App\Http\Controllers\API\V1\CartController;
use App\Http\Controllers\API\V1\CartItemController;
use App\Http\Controllers\API\V1\CheckoutController;
use App\Http\Controllers\API\V1\DeliveryRequestController;
use App\Http\Controllers\Api\V1\OrderController;
use App\Http\Controllers\API\V1\ProductController;
use App\Http\Controllers\API\V1\VendorOrderController;
use Illuminate\Support\Facades\Route;

Route::get('test', function () {
    return "Hello from Absher API";
});

///=======================================================
///                     Users
///=======================================================
///
Route::prefix('users')->group(function () {
    //
    Route::prefix('auth')->group(function () {
        //
        Route::post('/register', [AuthController::class, 'register']);
        Route::post('/login', [AuthController::class, 'login']);
        //
        Route::middleware(['auth:api'])->group(function () {
            Route::post('/logout', [AuthController::class, 'logout']);
            Route::get('/me', [AuthController::class, 'me']);
        });
    });
});


///=======================================================
///                     Products
///=======================================================
///
Route::prefix('products')->group(function () {
    //
    Route::get('/', [ProductController::class, 'index']);
    Route::get('/{id}', [ProductController::class, 'show']);
    //
    Route::middleware(['auth:api', 'role:vendor'])->group(function () {
        //
        Route::post('/', [ProductController::class, 'store']);
        Route::put('/{id}', [ProductController::class, 'update']);
        Route::delete('/{id}', [ProductController::class, 'destroy']);
    });
});


///=======================================================
///                     Carts
///=======================================================
///
Route::prefix('carts')->group(function () {
    //
    Route::middleware(['auth:api'])->group(function () {
        //
        Route::get('/', [CartController::class, 'index']);
        Route::post('/', [CartController::class, 'store']);
        Route::get('/{id}', [CartController::class, 'show']);
        Route::delete('/{id}', [CartController::class, 'destroy']);
        //
        Route::post('/items', [CartItemController::class, 'addItem']);
        Route::put('/items/{itemId}', [CartItemController::class, 'updateItem']);
        Route::delete('/items/{itemId}', [CartItemController::class, 'removeItem']);

        // Checkout
        Route::post('/{cartId}/checkout', [CheckoutController::class, 'checkoutCart'])->withoutMiddleware(['auth:api']);
    });
});


///=======================================================
///                     Orders
///=======================================================
///
Route::prefix('orders')->group(function () {
    //
    Route::get('/{order_id}', [OrderController::class, 'show']);
    //
    Route::patch('/pickup', [DeliveryRequestController::class, 'markAsPickedUp'])->middleware(['role:delivery']);
    Route::patch('/deliver', [DeliveryRequestController::class, 'markAsDelivered'])->middleware(['role:delivery']);
    //
    Route::patch('/cancel', [OrderController::class, 'cancel'])->middleware(['role:customer']);
})->middleware(['auth:api']);


///=======================================================
///                 Delivery Requests
///=======================================================
///
Route::prefix('delivery-requests')->group(function () {

    Route::middleware(['auth:api'])->group(function () {
        //  
        Route::post('/', [DeliveryRequestController::class, 'store'])->middleware(['role:delivery']);
        //
        Route::put('/{id}/status', [DeliveryRequestController::class, 'updateStatus'])->middleware(['role:vendor']);
    });
});


///=======================================================
///                     Vendor
///=======================================================
///
Route::prefix('vendors')->group(function () {
    //
    Route::post('/{vendor_id}/orders/{orderId}/publish', [VendorOrderController::class, 'publishOrder']);
    Route::get('/{vendor_id}/orders', [VendorOrderController::class, 'ordersToPublish']);
}); 
///TODO : ->middleware(['auth:api' , 'role:vendor']);