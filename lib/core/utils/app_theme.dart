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
    primaryColor: const Color(0xFF2C3E50), // Main Brand Color
    cardColor: const Color(0xFF1E293B), // Slate 800
    dividerColor: const Color(0xFF334155), // Slate 700
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2C3E50), // Unified Seed Color
      brightness: Brightness.dark,
      surface: const Color(0xFF1E293B), // Slate 800
      onSurface: const Color(0xFFF1F5F9), // Slate 100
      background: const Color(0xFF0F172A),
      outline: const Color(0xFF475569), // Slate 600
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B), // Slate 800
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2C3E50), // Brand Color
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF334155)),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF334155)),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF60A5FA),
        ), // Lighter Blue for focus
        borderRadius: BorderRadius.circular(16),
      ),
      hintStyle: const TextStyle(color: Color(0xFF64748B)),
    ),
  );
}
