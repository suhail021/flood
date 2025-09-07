import 'package:flutter/material.dart';

// نظام الألوان المبسط - لونان أساسيان فقط
class AppColors {
  // اللونان الأساسيان المختاران للتطبيق
  static const Color primaryBrown = Color(0xFF1E3A8A); // البني الداكن - اللون الأساسي
  static const Color tealBlue = Color(0xFF4A9B8E); // الأزرق المخضر - اللون الثانوي
  
  // ألوان مساعدة
  static const Color pureWhite = Color(0xFFFFFFFF); // الأبيض للنصوص
  static const Color lightBeige = Color(0xFFF5E6D3); // البيج الفاتح للخلفيات
  
  // ألوان إضافية للتطبيق
  static const Color lightBrown = Color(0xFFD2B48C); // البني الفاتح
  static const Color mediumBrown = Color(0xFFA0522D); // البني المتوسط
  static const Color darkBrown = Color(0xFF654321); // البني الداكن جداً
  
  // ألوان الحالة
  static const Color success = Color(0xFF2E7D32); // أخضر للنجاح
  static const Color warning = Color(0xFFF57C00); // برتقالي للتحذير
  static const Color error = Color(0xFFD32F2F); // أحمر للخطأ
  static const Color info = Color(0xFF1976D2); // أزرق للمعلومات
  
  // ألوان الخلفية
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF2C2C2C);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF3C3C3C);
  
  // ألوان النص
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnDark = Color(0xFFFFFFFF);
  
  // تدرجات الألوان
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBrown, mediumBrown],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient waterGradient = LinearGradient(
    colors: [tealBlue, Color(0xFF66B3A8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [lightBeige, Color(0xFFF0E6D2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// الثوابت القديمة (محتفظ بها للتوافق)
const kPrimaryColor = AppColors.primaryBrown;
const kTranstionDuration = Duration(milliseconds: 1500);
const kGtSectraFine = 'GT Sectra Fine';
