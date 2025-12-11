import 'package:flutter/material.dart';

abstract class AppColors {
  // ألوان أساسية - تدرجات الرمادي
  static const Color primaryColor = Color(0xFF2C3E50); // رمادي غامق أنيق
  static const Color lightPrimaryColor = Color(0xFF475569); // رمادي متوسط
  static const Color secondaryColor = Color(0xFF64748B); // رمادي فاتح
  static const Color lightsecondaryColor = Color(0xFF94A3B8); // رمادي فاتح جداً

  // ألوان الخلفية
  static const Color backgroundColor = Color(0xFFF8FAFC); // أبيض مزرق فاتح
  static const Color surfaceColor = Color(0xFFFFFFFF); // أبيض نقي
  static const Color cardColor = Color(0xFFF1F5F9); // رمادي فاتح جداً للكروت

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF1E293B); // نص رئيسي غامق
  static const Color textSecondary = Color(0xFF64748B); // نص ثانوي رمادي
  static const Color textLight = Color(0xFF94A3B8); // نص فاتح

  // ألوان أكسنت
  static const Color accentColor = Color(0xFF334155); // لون تركيز رمادي داكن
  static const Color borderColor = Color(0xFFE2E8F0); // لون الحدود
  static const Color dividerColor = Color(0xFFCBD5E1); // لون الفواصل

  // ألوان التدرج للخلفيات الجميلة
  static const Color gradientStart = Color(0xFFF8FAFC); // بداية التدرج
  static const Color gradientMiddle = Color(0xFFE2E8F0); // وسط التدرج
  static const Color gradientEnd = Color(0xFFCBD5E1); // نهاية التدرج
}
