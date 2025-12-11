import 'package:flutter/material.dart';
import 'package:google/screens/splash_screen.dart';

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
        // الخط
        fontFamily: 'Cairo',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3E50),
          primary: const Color(0xFF2C3E50),
          secondary: const Color(0xFF64748B),
          background: const Color(0xFFF8FAFC),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
