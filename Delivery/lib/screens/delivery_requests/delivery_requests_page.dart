import 'package:delivery_man/screens/delivery_requests/controller/deliver_requests_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RequestsTab extends StatelessWidget {
  const RequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestsController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Requests", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.requests.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchRequests,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 70.h,) ,
                Center(
                child: Text(
                  "No requests found",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              )],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.requests.length,
          itemBuilder: (context, index) {
            final request = controller.requests[index];
            final order = request.order;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.only(bottom: 12.h),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    // Vendor avatar
                    CircleAvatar(
                      radius: 28.r,
                      backgroundImage:
                          order.vendor != null &&
                              order.vendor!.avatarPath != null
                          ? NetworkImage(order.vendor!.image)
                          : const AssetImage(
                                  "assets/images/avatar_placeholder.png",
                                )
                                as ImageProvider,
                    ),
                    SizedBox(width: 12.w),

                    // Vendor info + status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.vendor != null &&
                                    order.vendor!.name.isNotEmpty
                                ? order.vendor!.name
                                : "Vendor name",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Status: ${request.status}",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Created: ${request.createdAt.toLocal()}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
