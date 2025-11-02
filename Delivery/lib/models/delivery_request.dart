//
//
//
import 'package:delivery_man/models/order.dart';

class DeliveryRequest {
  final int id;
  final int orderId;
  final int deliveryManId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Order order;

  DeliveryRequest({
    required this.id,
    required this.orderId,
    required this.deliveryManId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
  });

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) =>
      DeliveryRequest(
        id: json['id'],
        orderId: json['order_id'],
        deliveryManId: json['delivery_man_id'],
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        order: Order.fromJson(json['order']),
      );
}
