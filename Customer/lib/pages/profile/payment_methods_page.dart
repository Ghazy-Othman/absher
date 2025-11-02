import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  //
  List<Map<String, String>> methods = [
    {'id': '1', 'name': 'Visa **** 1234'},
    {'id': '2', 'name': 'Mastercard **** 5678'},
    {'id': '3', 'name': 'PayPal john.doe@example.com'},
  ];

  String defaultMethodId = '1';

  void _setDefaultMethod(String id) {
    setState(() {
      defaultMethodId = id;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Set as default payment method')),
    );
  }

  void _addNewMethod() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Payment Method'),
        content: Text('You can add new methods soon...'),
        actions: [
          TextButton(
            child: Text('Close', style: TextStyle(fontSize: 14.sp)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(Map<String, String> method) {
    bool isDefault = method['id'] == defaultMethodId;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isDefault ? Colors.lightGreen : Colors.grey.shade300, width: 1.5),
        boxShadow: isDefault
            ? [BoxShadow(color: Colors.lightGreen.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 3))]
            : null,
      ),
      child: Row(
        children: [
          Icon(Icons.payment, size: 28.sp, color: isDefault ? Colors.lightGreen : Colors.grey),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              method['name'] ?? '',
              style: TextStyle(fontSize: 16.sp, fontWeight: isDefault ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDefault ? Colors.grey : Colors.lightGreen,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: isDefault ? null : () => _setDefaultMethod(method['id']!),
            child: Text(
              isDefault ? 'Default' : 'Set Default',
              style: TextStyle(fontSize: 14.sp, color: isDefault ? Colors.white70 : Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _addNewMethod,
              icon: Icon(Icons.add, size: 20.sp),
              label: Text('Add New Method', style: TextStyle(fontSize: 16.sp)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: methods.isEmpty
                  ? Center(
                child: Text('No payment methods added yet.', style: TextStyle(fontSize: 16.sp)),
              )
                  : ListView.builder(
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  return _buildPaymentMethodItem(methods[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
