
import 'package:flutter/material.dart';
import 'package:google/screens/splash_screen.dart';
import 'package:google/constants.dart';

void main() {
  runApp(const FloodAlertApp());
}

class FloodAlertApp extends StatelessWidget {
  const FloodAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام التنبؤ الذكي للسيول',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // اللونان الأساسيان المختاران للتطبيق
        primaryColor: AppColors.primaryBrown, // البني الداكن - اللون الأساسي
        
        // نظام الألوان المبسط - لونان أساسيان فقط
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryBrown,      // البني الداكن - اللون الأساسي
          secondary: AppColors.tealBlue,         // الأزرق المخضر - اللون الثانوي
          surface: AppColors.surfaceLight,
          background: AppColors.backgroundLight,
          error: AppColors.error,
          onPrimary: AppColors.pureWhite,
          onSecondary: AppColors.pureWhite,
          onSurface: AppColors.textPrimary,
          onBackground: AppColors.textPrimary,
          onError: AppColors.pureWhite,
        ),
        
        // ألوان النص
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.textPrimary),
          displayMedium: TextStyle(color: AppColors.textPrimary),
          displaySmall: TextStyle(color: AppColors.textPrimary),
          headlineLarge: TextStyle(color: AppColors.textPrimary),
          headlineMedium: TextStyle(color: AppColors.textPrimary),
          headlineSmall: TextStyle(color: AppColors.textPrimary),
          titleLarge: TextStyle(color: AppColors.textPrimary),
          titleMedium: TextStyle(color: AppColors.textPrimary),
          titleSmall: TextStyle(color: AppColors.textPrimary),
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textPrimary),
          bodySmall: TextStyle(color: AppColors.textSecondary),
          labelLarge: TextStyle(color: AppColors.textPrimary),
          labelMedium: TextStyle(color: AppColors.textSecondary),
          labelSmall: TextStyle(color: AppColors.textSecondary),
        ),
        
        // ألوان المكونات
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryBrown,
          foregroundColor: AppColors.pureWhite,
          elevation: 2,
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBrown,
            foregroundColor: AppColors.pureWhite,
            elevation: 2,
          ),
        ),
        
        cardTheme: const CardThemeData(
          color: AppColors.surfaceLight,
          elevation: 2,
          shadowColor: AppColors.primaryBrown,
        ),
        
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryBrown),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.tealBlue, width: 2),
          ),
        ),
        
        // الخط
        fontFamily: 'Pacifico',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}