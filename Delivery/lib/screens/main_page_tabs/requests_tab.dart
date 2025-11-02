//
//
//
import 'package:delivery_man/controllers/request_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({super.key});

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  final controller = RequestController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return controller.acceptedOrder == null
        ? RefreshIndicator(
            onRefresh: () async {
              controller.resetOrders();
            },
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                final order = controller.orders[index];
                final isPending =
                    controller.pendingOrderId == order['orderNumber'];
                return Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.green.shade100,
                            child: Icon(Icons.store, color: Colors.green),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            order['vendor']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16.sp,
                            color: Colors.green,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "Pick Up: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order['pickup']!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.flag,
                            size: 16.sp,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "Drop Off: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order['dropoff']!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "${order['cost']}",
                        style: TextStyle(color: Colors.green, fontSize: 14.sp , fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Center(child: isPending
                          ? Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.orange,
                        ),
                      )
                          : ElevatedButton(
                        onPressed: controller.isRequesting
                            ? null
                            : () => controller.requestOrder(
                          order['orderNumber']!,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Request",
                          style: TextStyle(fontSize: 14.sp , color : Colors.white),
                        ),
                      ),)
                    ],
                  ),
                );
              },
            ),
          )
        : Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Number: ${controller.acceptedOrder!['orderNumber']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                _OrderSummaryCard(order: controller.acceptedOrder!),
                SizedBox(height: 12.h),
                _OrderItemsCard(),
                SizedBox(height: 12.h),
                _CustomerCard(),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  child: Text("Scan", style: TextStyle(fontSize: 16.sp , color : Colors.white)),
                ),
              ],
            ),
          );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderSummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.store, color: Colors.green),
                ),
                SizedBox(width: 10.w),
                Text(
                  order['vendor']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text("Pick Up: ${order['pickup']}"),
            Text("Drop Off: ${order['dropoff']}"),
            SizedBox(height: 6.h),
            Text(
              "Contact: ${order['phone']}",
              style: TextStyle(color: Colors.green.shade700),
            ),
            SizedBox(height: 6.h),
            Text(
              "Cost: ${order['cost']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemsCard extends StatelessWidget {
  const _OrderItemsCard();

  @override
  Widget build(BuildContext context) {
    final items = [
      {"name": "Burger Meal", "qty": 2, "price": 8000},
      {"name": "Fries", "qty": 1, "price": 2000},
    ];

    final total = items.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int),
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Items",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item['name']}", style: TextStyle(fontSize: 14.sp)),
                    Text(
                      "Qty: ${item['qty']}  |  ${item['price']} SP",
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: $total SP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deliver To",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.person, color: Colors.green),
                ),
                SizedBox(width: 10.w),
                Text("Customer Name", style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            SizedBox(height: 6.h),
            Text("Phone: +963987654321", style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 8.h),
            Text(
              "Note:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            Text("Please call me when you arrive."),
          ],
        ),
      ),
    );
  }
}
