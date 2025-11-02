//
//
//
import 'package:delivery_man/models/user.dart';

import 'cart.dart';

class Order {
  final int id;
  final int customerId;
  final int vendorId;
  final int? deliverymanId;
  final int total;
  final int deliveryCost;
  final String? pickupAddress;
  final String? deliveryAddress;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int cartId;
  final User? customer;
  final Cart? cart;
  final User? vendor;

  // itemsCount: sum of quantities in cart items (computed)
  final int itemsCount;

  Order({
    required this.id,
    required this.customerId,
    required this.vendorId,
    this.deliverymanId,
    required this.total,
    required this.deliveryCost,
    this.pickupAddress,
    this.deliveryAddress,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cartId,
    this.customer,
    this.cart,
    this.vendor,
    required this.itemsCount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final cartJson = json['cart'];
    final Cart? cart = cartJson != null ? Cart.fromJson(cartJson) : null;
    final itemsCount =
        cart?.items.fold<int>(0, (s, it) => s + it.quantity) ?? 0;

    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      vendorId: json['vendor_id'],
      deliverymanId: json['deliveryman_id'],
      total: json['total'] ?? 0,
      deliveryCost: json['delivery_cost'] ?? 0,
      pickupAddress: json['pickup_address'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      cartId: json['cart_id'],
      customer: json['customer'] != null
          ? User.fromJson(json['customer'])
          : null,
      cart: cart,
      vendor: json['vendor'] != null ? User.fromJson(json['vendor']) : null,
      itemsCount: itemsCount,
    );
  }
}
