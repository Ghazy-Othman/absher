//
//
//
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RequestsHistoryTab extends StatelessWidget {
  const RequestsHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        backgroundColor: AppTheme.darkBlue,
      ),
      body: Center(child: Text("Soon")),
    );
  }
}
