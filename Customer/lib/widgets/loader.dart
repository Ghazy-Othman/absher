import 'package:flutter/material.dart';
import 'package:mobile/theme/app_theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppTheme.darkBlue));
  }
}
