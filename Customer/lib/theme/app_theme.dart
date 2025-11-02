//
//
//
import 'package:flutter/material.dart';

class AppTheme {
  /// Brand Colors
  static final Color primaryBlue = const Color(0xFF1565C0);
  static final Color darkBlue = const Color(0xFF0D47A1);
  static final Color accentBlue = const Color(0xFF42A5F5);

  /// Text Colors
  static final Color primaryText = const Color(0xFF212121); // Main text
  static final Color secondaryText = const Color(0xFF757575); // Subtext
  static final Color hintText = const Color(0xFF9E9E9E); // Placeholders/hints

  /// Divider / Border Color
  static final Color divider = const Color(0xFFE0E0E0);

  /// Light Theme
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: primaryBlue, secondary: accentBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    ),
    dividerColor: divider,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF212121)),
      bodyMedium: TextStyle(color: Color(0xFF757575)),
    ),
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: darkBlue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(primary: darkBlue, secondary: accentBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 1,
    ),
    dividerColor: Colors.grey.shade800,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
    ),
  );
}
