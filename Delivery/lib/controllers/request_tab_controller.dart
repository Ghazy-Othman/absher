//
//
//
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RequestController extends ChangeNotifier {
  ///
  Map<String, dynamic>? acceptedOrder;
  bool isRequesting = false;
  String? pendingOrderId;
  List<Map<String, String>> orders = [
    {
      "vendor": "Burger King",
      "desc": "Deliver 2 meals to downtown",
      "pickup": "Burger King Branch",
      "dropoff": "Customer Address",
      "cost": "5000 SP",
      "phone": "+963987654321",
      "orderNumber": "#BK1023",
    },
    {
      "vendor": "Pizza Hub",
      "desc": "Pizza Margherita delivery",
      "pickup": "Pizza Hub Central",
      "dropoff": "Customer Office",
      "cost": "4000 SP",
      "phone": "+963912345678",
      "orderNumber": "#PH232",
    },{
      "vendor": "Burger King",
      "desc": "Deliver 2 meals to downtown",
      "pickup": "Burger King Branch",
      "dropoff": "Customer Address",
      "cost": "5000 SP",
      "phone": "+963987654321",
      "orderNumber": "#BK2023",
    },
    {
      "vendor": "Pizza Hub",
      "desc": "Pizza Margherita delivery",
      "pickup": "Pizza Hub Central",
      "dropoff": "Customer Office",
      "cost": "4000 SP",
      "phone": "+963912345678",
      "orderNumber": "#PL232",
    },{
      "vendor": "Burger King",
      "desc": "Deliver 2 meals to downtown",
      "pickup": "Burger King Branch",
      "dropoff": "Customer Address",
      "cost": "5000 SP",
      "phone": "+963987654321",
      "orderNumber": "#BK1093",
    },
    {
      "vendor": "Pizza Hub",
      "desc": "Pizza Margherita delivery",
      "pickup": "Pizza Hub Central",
      "dropoff": "Customer Office",
      "cost": "4000 SP",
      "phone": "+963912345678",
      "orderNumber": "#PH777",
    },{
      "vendor": "Burger King",
      "desc": "Deliver 2 meals to downtown",
      "pickup": "Burger King Branch",
      "dropoff": "Customer Address",
      "cost": "5000 SP",
      "phone": "+963987654321",
      "orderNumber": "#BAA523",
    },
    {
      "vendor": "Pizza Hub",
      "desc": "Pizza Margherita delivery",
      "pickup": "Pizza Hub Central",
      "dropoff": "Customer Office",
      "cost": "4000 SP",
      "phone": "+963912345678",
      "orderNumber": "#P8S32",
    },
  ];

  ///
  void requestOrder(String orderId) {
    isRequesting = true;
    pendingOrderId = orderId;
    notifyListeners();

    // Simulate backend approval
    Timer(Duration(seconds: 3), () {
      bool accepted = Random().nextBool();
      if (accepted) {
        acceptedOrder = orders.firstWhere((o) => o['orderNumber'] == orderId);
      }
      else {
        pendingOrderId = null ;
      }
      isRequesting = false;
      notifyListeners();
    });
  }

  ///
  void resetOrders() {
    acceptedOrder = null;
    pendingOrderId = null;
    notifyListeners();
  }
}
