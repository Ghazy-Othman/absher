//
//
//
import 'package:admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static bool _isDialogOpen = false;

  /// Show loading dialog
  static void show() {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    Get.dialog(const _LoaderDialog(), barrierDismissible: false);
  }

  /// Close loading dialog
  static void cancel() {
    if (_isDialogOpen) {
      Get.back();
      _isDialogOpen = false;
    }
  }
}

class _LoaderDialog extends StatelessWidget {
  const _LoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).dialogTheme.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color, blurRadius: 10, spreadRadius: 1)],
        ),
        padding: const EdgeInsets.all(20),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: 3.5,
        ),
      ),
    );
  }
}

class CirLoader extends StatelessWidget {
  const CirLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppTheme.darkBlue));
  }
}
