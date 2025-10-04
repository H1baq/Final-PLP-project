import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF7F56D9);
  static const Color accent = Color(0xFFFF8FB1);
  static const Color background = Color(0xFFFDFBFF);
  static const Color darkText = Color(0xFF2B2146);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: background,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
      unselectedItemColor: Colors.black54,
    ),
  );
}
