//
//
//

import 'package:delivery_man/models/product.dart';

class Cart {
  final int id;
  final int userId;
  final int vendorId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json['id'],
    userId: json['user_id'],
    vendorId: json['vendor_id'],
    status: json['status'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    items: (json['items'] as List<dynamic>)
        .map((e) => CartItem.fromJson(e))
        .toList(),
  );
}

///
class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final double totalPrice;
  final Product product;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    cartId: json['cart_id'],
    productId: json['product_id'],
    quantity: json['quantity'],
    totalPrice: (json['total_price'] as num).toDouble(),
    product: Product.fromJson(json['product']),
  );
}
