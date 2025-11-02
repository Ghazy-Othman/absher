//
//
//
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/home/controller/home_page_controller.dart';
import 'package:admin/views/home/controller/orders_tab_controller.dart';
import 'package:admin/views/home/controller/delivery_requests_tab_controller.dart';
import 'package:admin/views/widgets/main_delivery_request_card.dart';
import 'package:admin/views/widgets/main_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  ///
  final homeController = Get.put(HomePageController());
  final ordersController = Get.put(OrdersTabController());
  final deliveryRequestsController = Get.put(DeliveryRequestsTabController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.darkBlue,
          title: Text("Home", style: TextStyle(fontSize: 18.sp)),
          bottom: TabBar(
            indicatorColor: AppTheme.accentBlue,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: "Orders"),
              Tab(text: "Delivery Requests"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            /// Orders Tab
            Obx(() {
              //
              if (ordersController.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }
              //
              if (ordersController.errorMessage.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: ordersController.fetchOrders,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 200.h),
                          child:
                              deliveryRequestsController.errorMessage.isNotEmpty
                              ? Text(
                                  deliveryRequestsController.errorMessage.value,
                                )
                              : const Text("No orders yet..."),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return buildOrdersTab(ordersController);
            }),

            /// Delivery Requests Tab
            Obx(() {
              if (deliveryRequestsController.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }
              if (deliveryRequestsController.errorMessage.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: deliveryRequestsController.fetchRequests,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 200.h),
                          child:
                              deliveryRequestsController.errorMessage.isNotEmpty
                              ? Text(
                                  deliveryRequestsController.errorMessage.value,
                                )
                              : const Text("No delivery requests yet..."),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return buildDeliveryRequestsTab(deliveryRequestsController);
            }),
          ],
        ),
      ),
    );
  }

  ///
  Widget buildOrdersTab(OrdersTabController ordersController) {
    final List<Map<String, dynamic>> statuses = [
      {"label": "All", "color": const Color(0xFF454747)}, // Orange
      {"label": "Pending", "color": const Color(0xFFFFA500)}, // Orange
      {"label": "Cancelled", "color": const Color(0xFFE53935)}, // Red
      {"label": "Assigned", "color": const Color(0xFF1E88E5)}, // Blue
      {"label": "Picked Up", "color": const Color(0xFF8E24AA)}, // Purple
      {"label": "Published", "color": const Color(0xFF43A047)}, // Green
      {"label": "Delivered", "color": const Color(0xFF2E7D32)}, // Dark Green
    ];
    return Column(
      children: [
        //
        Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected =
                  ordersController.selectedStatus.value == status["label"];

              return GestureDetector(
                onTap: () {
                  ordersController.selectedStatus.value = status["label"];
                  ordersController.fetchOrders();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    // vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? status["color"].withOpacity(0.9)
                        : status["color"].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? status["color"] : Colors.transparent,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      status["label"],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        //
        Expanded(
          child: Obx(() {
            if (ordersController.isLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }
            if (ordersController.errorMessage.isNotEmpty ||
                ordersController.orders.isEmpty) {
              return RefreshIndicator(
                onRefresh: ordersController.fetchOrders,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 200.h),
                        child: ordersController.errorMessage.isNotEmpty
                            ? Text(ordersController.errorMessage.value)
                            : const Text("No orders yet..."),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: ordersController.fetchOrders,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4.h),
                itemCount: ordersController.orders.length,
                itemBuilder: (context, index) {
                  final order = ordersController.orders[index];
                  return OrderCard(order: order);
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  ///
  Widget buildDeliveryRequestsTab(
    DeliveryRequestsTabController ordersController,
  ) {
    final List<Map<String, dynamic>> statuses = [
      {"label": "All", "color": const Color(0xFF454747)}, // Orange
      {"label": "Pending", "color": const Color(0xFFFFA500)}, // Orange
      {"label": "Declined", "color": const Color(0xFFE53935)}, // Red
      {"label": "Approved", "color": const Color(0xFF2E7D32)}, // Dark Green
    ];
    return Column(
      children: [
        Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected =
                  ordersController.selectedStatus.value == status["label"];

              return GestureDetector(
                onTap: () {
                  ordersController.selectedStatus.value = status["label"];
                  ordersController.fetchRequests();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    // vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? status["color"].withOpacity(0.9)
                        : status["color"].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? status["color"] : Colors.transparent,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      status["label"],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            if (ordersController.isLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }
            if (deliveryRequestsController.errorMessage.isNotEmpty ||
                deliveryRequestsController.requests.isEmpty) {
              return RefreshIndicator(
                onRefresh: deliveryRequestsController.fetchRequests,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 200.h),
                        child:
                            deliveryRequestsController.errorMessage.isNotEmpty
                            ? Text(
                                deliveryRequestsController.errorMessage.value,
                              )
                            : const Text("No delivery requests yet..."),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: deliveryRequestsController.fetchRequests,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 16.h),
                itemCount: deliveryRequestsController.requests.length,
                itemBuilder: (context, index) {
                  final request = deliveryRequestsController.requests[index];
                  return DeliveryRequestCard(
                    request: request,
                    onApprove: () {
                      deliveryRequestsController.updateDeliveryRequestStatus(
                        request.id!,
                        "approved",
                      );
                    },
                    onDecline: () {
                      deliveryRequestsController.updateDeliveryRequestStatus(
                        request.id!,
                        "declined",
                      );
                    },
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
