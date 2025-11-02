//
//
//
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/profile/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(NotificationsController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text("Notification")),
    );
  }
}
