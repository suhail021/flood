import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    primaryColor: const Color(0xFF2C3E50),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2C3E50),
      primary: const Color(0xFF2C3E50),
      secondary: const Color(0xFF64748B),
      surface: Colors.white,
      onSurface: const Color(0xFF2C3E50), // Text color
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2C3E50),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
    primaryColor: const Color(0xFF2C3E50),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(
        0xFF3B82F6,
      ), // Blue 500 for better contrast or keep brand? Let's try to match brand but adapted.
      brightness: Brightness.dark,
      primary: const Color(0xFF60A5FA), // Blue 400 - lighter for dark mode
      secondary: const Color(0xFF94A3B8), // Slate 400
      surface: const Color(0xFF1E293B), // Slate 800
      onSurface: const Color(0xFFF1F5F9), // Slate 100
      background: const Color(0xFF0F172A),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B), // Slate 800
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // Customize other components as needed for dark mode visibility
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6), // Blue 500
        foregroundColor: Colors.white,
      ),
    ),
  );
}
