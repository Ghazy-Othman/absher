///
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

  /// Divider / Surface
  static final Color divider = const Color(0xFFE0E0E0);
  static final Color surface = Colors.white;

  /// Shared text theme
  static final TextTheme _lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF212121)),
    bodyMedium: TextStyle(color: Color(0xFF757575)),
    titleLarge: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.w600),
  );

  static final TextTheme _darkTextTheme = const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
  );

  /// Light Theme
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: surface,
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      secondary: accentBlue,
      surface: surface,
      onPrimary: Colors.white,
      onSurface: primaryText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 1,
      titleTextStyle: _lightTextTheme.titleLarge?.copyWith(fontSize: 18),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    dividerColor: divider,
    dividerTheme: DividerThemeData(color: divider, thickness: 1),
    textTheme: _lightTextTheme,
    primaryTextTheme: _lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: primaryBlue),
      hintStyle: TextStyle(color: hintText),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryBlue)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: divider)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: primaryBlue),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryBlue,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: darkBlue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: darkBlue,
      secondary: accentBlue,
      surface: const Color(0xFF1E1E1E),
      onPrimary: Colors.white,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBlue,
      foregroundColor: Colors.white,
      elevation: 1,
      titleTextStyle: _darkTextTheme.titleLarge?.copyWith(fontSize: 18),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    dividerColor: Colors.grey.shade800,
    dividerTheme: DividerThemeData(color: Colors.grey.shade800, thickness: 1),
    textTheme: _darkTextTheme,
    primaryTextTheme: _darkTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: accentBlue),
      hintStyle: TextStyle(color: hintText),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentBlue)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade800)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkBlue,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: accentBlue),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: darkBlue,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
  );
}
