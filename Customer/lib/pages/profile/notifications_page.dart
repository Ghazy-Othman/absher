//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool promotion = true;
  bool orderStatus = true;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildNotificationRow("Promotion", promotion, (value) {
              setState(() => promotion = value);
            }),
            Divider(),
            _buildNotificationRow("New Order Status", orderStatus, (value) {
              setState(() => orderStatus = value);
            }),
            Divider(),
            _buildNotificationRow("Email Notification", email, (value) {
              setState(() => email = value);
            }),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationRow(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.sp)),
        Switch(
          value: value,
          activeColor: Colors.lightGreen,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
