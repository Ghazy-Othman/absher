import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentPage extends StatefulWidget {
  final double total;

  const PaymentPage({super.key, required this.total});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = "Visa Card";

  void showPaymentMethods() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: const Text("Visa Card"),
              onTap: () => selectMethod("Visa Card"),
            ),
            ListTile(
              title: const Text("PayPal"),
              onTap: () => selectMethod("PayPal"),
            ),
            ListTile(
              title: const Text("Apple Pay"),
              onTap: () => selectMethod("Apple Pay"),
            ),
          ],
        );
      },
    );
  }

  void selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
    Navigator.pop(context);
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your payment is success"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Total Payment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment",
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  "\$${widget.total.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Payment Method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                TextButton(
                  onPressed: showPaymentMethods,
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedMethod,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),

            const Spacer(),

            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: showSuccessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  "Pay",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
