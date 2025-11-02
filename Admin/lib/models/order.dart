//
//
//
import 'package:admin/models/cart.dart';
import 'package:admin/models/customer.dart';

class Order {
  ///
  int? id;
  int? vendorId;
  int? customerId;
  String? status;
  int? cartId;
  Customer? customer;
  Cart? cart;

  int? deliveryCost;
  int? total;
  int? deliveryManId;
  String? pickupAddress;
  String? deliveryAddress;
  String? notes;

  ///TODO : Add delivered at (Date)

  ///
  Order({
    this.id,
    this.vendorId,
    this.status,
    this.customerId,
    this.cartId,
    this.customer,
    this.cart,
    this.total,
    this.deliveryAddress,
    this.pickupAddress,
    this.deliveryManId,
    this.notes,
    this.deliveryCost,
  });

  ///
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      cartId: json['cart_id'],
      vendorId: json['vendor_id'],
      customerId: json['customer_id'],
      deliveryManId: json['deliveryman_id'],
      total: json['total'] != null ? (json['total'] as int) : null,
      status: json['status'],
      deliveryAddress: json['delivery_address'],
      pickupAddress: json['pickup_address'],
      notes: json['notes'],
      deliveryCost: json['delivery_cost'],
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'])
          : null,
      cart: json['cart'] != null ? Cart.fromJson(json['cart']) : null,
    );
  }

  ///
  Map<String, dynamic> toJson() => {
    'id': id,
    'vendor_id': vendorId,
    'customer_id': customerId,
    'deliveryman_id': deliveryManId,
    'total': total,
    'status': status,
    'pickup_address': pickupAddress,
    'delivery_address': deliveryAddress,
    'notes': notes,
    'delivery_cost': deliveryCost,
    'cart_id': cartId,
    'customer': customer!.toJson(),
    'cart': cart!.toJson(),
  };
}
