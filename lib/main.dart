import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google/screens/splash_screen.dart';
import 'core/localization/messages.dart';
import 'core/utils/app_theme.dart';

import 'package:google/services/notification_service.dart';
import 'package:google/controllers/alert_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  await NotificationService().init();

  // Initialize AlertController immediately to start polling
  Get.put(AlertController());

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
      translations: Messages(),
      locale: initialLang != null ? Locale(initialLang!) : const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode
              .system, // Will be overridden by controller/GetX logic but good default
      builder: (context, child) {
        // Obx to listen to locale changes if needed, but GetMaterialApp usually handles it.
        // However, standard Directionality needs to be updated if we want to support LTR.
        // Get.locale might be null initially?
        return Directionality(
          textDirection:
              Get.locale?.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
