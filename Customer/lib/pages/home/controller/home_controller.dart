//
//
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/pages/orders/order_details_page.dart';
import 'package:mobile/services/product_service.dart';
import 'package:mobile/services/web_socket_service.dart';

class HomeController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var products = <Product>[].obs;
  List<Map<String, dynamic>> categories = [];

  ///
  List<Product> trendingProduct = [];
  List<Product> flashProducts = [];
  List<Product> lastSearchProduct = [];
  List<Product> recommendedProduct = [];

  ///
  WebSocketService socketService = WebSocketService();
  Map<String, Function(Map<String, dynamic>)> eventsHandlers = {};

  @override
  void onInit() {
    getProducts();
    _initEventsHandlers();
    socketService.subscribe("orders_published", eventsHandlers);
    socketService.subscribe("orders_assigned", {});
    socketService.subscribe("orders_picked_up", {});
    socketService.subscribe("orders_delivered", {});
    super.onInit();
  }

  ///
  IconData _buildCategoryIcon(String name) {
    IconData res = Icons.category;
    switch (name) {
      case "fashion":
        res = Icons.checkroom;
        break;
      case "sport":
        res = Icons.sports_soccer;
        break;
      case "smart_phones":
        res = Icons.smartphone;
        break;
      case "food":
        res = Icons.fastfood;
        break;
      case "electronic":
        res = Icons.devices_other;
        break;
      case "gamin":
        res = Icons.sports_esports;
        break;
      case "books":
        res = Icons.menu_book;
        break;
      case "health":
        res = Icons.health_and_safety;
        break;
    }
    return res;
  }

  ///
  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await ProductService.getHomePageProducts();
      products.value = response['products'];
      categories = (response['categories'] as List<Category>)
          .map(
            (cat) => {
              "id": cat.id,
              "name": cat.name,
              "icon": _buildCategoryIcon(cat.name.toLowerCase()),
            },
          )
          .toList();
      trendingProduct = (List<Product>.from(
        products,
      )..shuffle()).take(Random().nextInt(6) + 3).toList();
      flashProducts = (List<Product>.from(
        products,
      )..shuffle()).take(Random().nextInt(6) + 3).toList();
      for (int i = 0; i < 10; i++) {
        lastSearchProduct.add(products[i]);
      }
      recommendedProduct = (List<Product>.from(
        products,
      )..shuffle()).take(Random().nextInt(products.length - 1) + 10).toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _initEventsHandlers() {
    final currentUserId = 1;
    eventsHandlers = {
      "order.published": (data) {
        Order publishedOrder = Order.fromJson(data['order']);
        if (publishedOrder.customerId == currentUserId) {
          Get.snackbar(
            "Published",
            "You order has been published",
            backgroundColor: Colors.green[100],
            onTap: (snack) {
              Get.to(() => OrderDetailsPage(orderId: publishedOrder.id));
            },
          );
        }
      },
      "order.assigned": (data) {
        Order publishedOrder = Order.fromJson(data['order']);
        if (publishedOrder.customerId == currentUserId) {
          Get.snackbar(
            "Assigned",
            "You order has been assigned to a delivery man",
            backgroundColor: Colors.orange[100],
            onTap: (snack) {
              Get.to(() => OrderDetailsPage(orderId: publishedOrder.id));
            },
          );
        }
      },
      "order.picked_up": (data) {
        Order publishedOrder = Order.fromJson(data['order']);
        if (publishedOrder.customerId == currentUserId) {
          Get.snackbar(
            "Picked Up",
            "You order has been picked up by delivery man",
            backgroundColor: Colors.blue[100],
            onTap: (snack) {
              Get.to(() => OrderDetailsPage(orderId: publishedOrder.id));
            },
          );
        }
      },
      "order.delivered": (data) {
        Order publishedOrder = Order.fromJson(data['order']);
        if (publishedOrder.customerId == currentUserId) {
          Get.snackbar(
            "Delivered",
            "You order has been delivered successfully",
            backgroundColor: Colors.purple[100],
            onTap: (snack) {
              Get.to(() => OrderDetailsPage(orderId: publishedOrder.id));
            },
          );
        }
      },
    };
  }
}
