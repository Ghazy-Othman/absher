//
//
//
import 'package:admin/models/product.dart';

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

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['user_id'],
      vendorId: json['vendor_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'vendor_id': vendorId,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'items': items.map((item) => item.toJson()).toList(),
  };
}

///
class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final int totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product ;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.product
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cart_id': cartId,
    'product_id': productId,
    'quantity': quantity,
    'total_price': totalPrice,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'product' : product.toJson()
  };
}
