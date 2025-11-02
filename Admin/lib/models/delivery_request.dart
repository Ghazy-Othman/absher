//
//
//
import 'package:admin/models/order.dart';

class DeliveryRequest {
  ///
  int? id;
  int? orderId;
  int? deliveryManId;
  String? status;
  Order? order;
  DeliveryMan? deliveryMan;

  ///
  DeliveryRequest({
    this.id,
    this.order,
    this.status,
    this.orderId,
    this.deliveryManId,
    this.deliveryMan,
  });

  ///
  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      id: json['id'],
      orderId: json['order_id'],
      status: json['status'],
      deliveryManId: json['delivery_man_id'],
      order: Order.fromJson(json['order']),
      deliveryMan: DeliveryMan.fromJson(json['delivery_man']),
    );
  }
}

class DeliveryMan {
  ///
  int? id;
  String? name;
  String? email;
  String? avatar;

  ///
  DeliveryMan({this.id, this.avatar, this.name, this.email});

  ///
  factory DeliveryMan.fromJson(Map<String, dynamic> json) {
    return DeliveryMan(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
