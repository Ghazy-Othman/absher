<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->foreignId('cart_id')->nullable()->constrained('carts')->after('vendor_id')->nullOnDelete();
            $table->unsignedBigInteger('total')->default(0)->after('deliveryman_id');
            $table->unsignedBigInteger('delivery_cost')->nullable()->after('total');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['delivery_cost', 'total']);
            $table->dropForeign(['cart_id']);
            $table->dropColumn('cart_id');
        });
    }
};
