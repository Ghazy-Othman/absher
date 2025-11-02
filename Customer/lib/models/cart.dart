//
//
//
import 'package:mobile/models/product.dart';
import 'package:mobile/models/vendor.dart';

class Cart {
  ///
  int? id;
  String? status;
  List<CartItem>? items;
  Vendor? vendor;

  ///
  Cart({this.id, this.status, this.items, this.vendor});

  ///
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      status: json['status'],
      items: json['items'] != null
          ? (json['items'] as List)
                .map((item) => CartItem.fromJson(item))
                .toList()
          : [],
      vendor: json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
    );
  }

  ///
  int get totalItems => items!.fold(0, (sum, item) => sum + item.quantity!);

  ///
  double get totalPrice =>
      items!.fold(0, (sum, item) => sum + item.totalPrice!);
}

class CartItem {
  ///
  int? id;
  int? quantity;
  int? totalPrice;
  Product? product;

  ///
  CartItem({this.id, this.quantity, this.totalPrice, this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }
}
