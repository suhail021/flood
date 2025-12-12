import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? savedLang = prefs.getString('language_code');
  runApp(FloodAlertApp(initialLang: savedLang));
}

class FloodAlertApp extends StatelessWidget {
  final String? initialLang;
  const FloodAlertApp({super.key, this.initialLang});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'نظام التنبؤ الذكي للسيول',
      debugShowCheckedModeBanner: false,
      locale: initialLang != null ? Locale(initialLang!) : const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      theme: ThemeData(
        // الخط
        fontFamily: 'Cairo',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3E50),
          primary: const Color(0xFF2C3E50),
          secondary: const Color(0xFF64748B),
          background: const Color(
            0xFFF8FAFC,
          ), // Corrected property name if needed, or just keep as is if custom
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const SplashScreen(),
    );
  }
}
