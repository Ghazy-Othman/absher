//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/carts/controller/carts_tab_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/cart_card.dart';

class CartsPage extends StatelessWidget {
  final controller = Get.put(CartsController());

  CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.darkBlue,
        title: Text("Carts", style: TextStyle(color: AppTheme.primaryText)),
      ),
      body: Obx(() {
        ///
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        ///
        if (controller.errorMessage.isNotEmpty || controller.carts.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchCarts();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: controller.errorMessage.isNotEmpty
                        ? Text(controller.errorMessage.value)
                        : Text("No carts available"),
                  ),
                ),
              ],
            ),
          );
        }

        ///
        return RefreshIndicator(
          onRefresh: controller.fetchCarts,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 12.h),
            itemCount: controller.carts.length,
            itemBuilder: (context, index) {
              final cart = controller.carts[index];
              return CartCard(
                cart: cart,
                onLongPress: () {
                  ///TODO : Show dialog to confirm deletion
                  controller.deleteCart(cart.id!);
                },
              );
            },
          ),
        );
      }),
    );
  }
}
