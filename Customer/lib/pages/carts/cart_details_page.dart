//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/carts/controller/cart_controller.dart';
import 'package:mobile/theme/app_theme.dart';

class CartDetailsPage extends StatelessWidget {
  final int cartId;
  final Color yellow = const Color(0xFFFFBF00);
  final Color grey = const Color(0xFFA39F9F);

  CartDetailsPage({super.key, required this.cartId});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    // Init fetch
    controller.fetchCart(cartId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Details", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppTheme.darkBlue,
        actions: [
          Obx(() {
            if (controller.cart.value != null) {
              return TextButton(
                onPressed: () {
                  controller.checkout();
                },
                child: Text(
                  "checkout".toUpperCase(),
                  style: TextStyle(color: AppTheme.accentBlue),
                ),
              );
            }
            return SizedBox();
          }),
        ],
      ),
      body: Obx(() {
        ///
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        ///
        if (controller.errorMessage.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchCart(cartId);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: Text(controller.errorMessage.value),
                  ),
                ),
              ],
            ),
          );
        }

        ///
        final cart = controller.cart.value!;
        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchCart(cartId);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Info
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cart ID: ${cart.id}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Status: ${cart.status!.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Total Items: ${cart.totalItems}",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          "Total Price: \$${cart.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // Vendor Info
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: grey,
                      backgroundImage: cart.vendor!.avatar != null
                          ? NetworkImage(cart.vendor!.avatar!)
                          : null,
                      child: cart.vendor!.avatar == null
                          ? Icon(Icons.store, color: Colors.white, size: 20.sp)
                          : null,
                    ),
                    title: Text(
                      cart.vendor!.name!,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    subtitle: Text(
                      cart.vendor!.address ?? "No address",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.accentBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // Items
                Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                SizedBox(height: 8.h),

                Column(
                  children: cart.items!.map((item) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      child: ListTile(
                        leading: Container(
                          width: 50.w,
                          height: 50.w,
                          color: grey,
                          child: item.product!.image != null
                              ? Image.network(
                                  item.product!.image!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image_not_supported, size: 20.sp),
                        ),
                        title: Text(
                          item.product!.name!,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        subtitle: Text(
                          "Qty: ${item.quantity}  |  Price: \$${item.totalPrice!.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                size: 20.sp,
                                color: Colors.redAccent,
                              ),
                              onPressed: () =>
                                  controller.decreaseCartItemQuantity(
                                    cartId: cartId,
                                    itemId: item.id!,
                                  ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                size: 20.sp,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () =>
                                  controller.increaseCartItemQuantity(
                                    cartId: cartId,
                                    itemId: item.id!,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
