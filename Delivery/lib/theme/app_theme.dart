//
//
//
import 'package:flutter/material.dart';

class AppTheme {
  ///
  static final Color primaryBlue = const Color(0xFF1565C0);
  static final Color darkBlue = const Color(0xFF0D47A1);
  static final Color accentBlue = const Color(0xFF42A5F5);

  ///
  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  ///
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: primaryBlue, secondary: accentBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    ),
  );

  ///
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: darkBlue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(primary: darkBlue, secondary: accentBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 1,
    ),
  );
}
