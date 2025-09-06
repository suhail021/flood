import 'package:flutter/material.dart';

/// لوحة الألوان الشاملة للتطبيق المستوحاة من الشعار
/// 
/// هذا الملف يحتوي على جميع الألوان والتدرجات المستخدمة في التطبيق
/// مع أمثلة على الاستخدام والتطبيق
class AppColorPalette {
  
  // ========== الألوان الأساسية من الشعار ==========
  
  /// البني الداكن - اللون الأساسي للمباني والحدود في الشعار
  /// يستخدم للأزرار الرئيسية، شريط التطبيق، والعناصر المهمة
  static const Color primaryBrown = Color(0xFF8B4513);
  
  /// البيج الفاتح - لون الخلفية والسماء في الشعار
  /// يستخدم لخلفيات الشاشات والعناصر الثانوية
  static const Color lightBeige = Color(0xFFF5E6D3);
  
  /// الأزرق المخضر - لون المياه/القناة في الشعار
  /// يستخدم للعناصر الثانوية، الروابط، والتركيز
  static const Color tealBlue = Color(0xFF4A9B8E);
  
  /// الأحمر الداكن - لون الدبوس/المؤشر في الشعار
  /// يستخدم للتنبيهات المهمة والتحذيرات
  static const Color darkRed = Color(0xFF8B0000);
  
  /// الأبيض النقي - لون النوافذ والنص في الشعار
  /// يستخدم للنصوص على الخلفيات الداكنة
  static const Color pureWhite = Color(0xFFFFFFFF);
  
  // ========== تدرجات الألوان الأساسية ==========
  
  /// تدرج البني الأساسي
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBrown, Color(0xFFA0522D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// تدرج المياه/القناة
  static const LinearGradient waterGradient = LinearGradient(
    colors: [tealBlue, Color(0xFF66B3A8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// تدرج الخلفية الفاتح
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [lightBeige, Color(0xFFF0E6D2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // ========== ألوان إضافية للتطبيق ==========
  
  /// البني الفاتح - للعناصر الثانوية
  static const Color lightBrown = Color(0xFFD2B48C);
  
  /// البني المتوسط - للحدود والخطوط
  static const Color mediumBrown = Color(0xFFA0522D);
  
  /// البني الداكن جداً - للنصوص والعناصر المظلمة
  static const Color darkBrown = Color(0xFF654321);
  
  // ========== ألوان الحالة ==========
  
  /// أخضر النجاح - للعمليات الناجحة
  static const Color success = Color(0xFF2E7D32);
  
  /// برتقالي التحذير - للتحذيرات
  static const Color warning = Color(0xFFF57C00);
  
  /// أحمر الخطأ - للأخطاء والتنبيهات المهمة
  static const Color error = Color(0xFFD32F2F);
  
  /// أزرق المعلومات - للمعلومات العامة
  static const Color info = Color(0xFF1976D2);
  
  // ========== ألوان الخلفية ==========
  
  /// خلفية فاتحة للشاشات الرئيسية
  static const Color backgroundLight = Color(0xFFFAFAFA);
  
  /// خلفية داكنة للوضع الليلي
  static const Color backgroundDark = Color(0xFF2C2C2C);
  
  /// سطح فاتح للبطاقات والحاويات
  static const Color surfaceLight = Color(0xFFFFFFFF);
  
  /// سطح داكن للوضع الليلي
  static const Color surfaceDark = Color(0xFF3C3C3C);
  
  // ========== ألوان النص ==========
  
  /// النص الأساسي - للعناوين والنصوص المهمة
  static const Color textPrimary = Color(0xFF212121);
  
  /// النص الثانوي - للنصوص الفرعية
  static const Color textSecondary = Color(0xFF757575);
  
  /// النص المعطل - للعناصر غير النشطة
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  /// النص على الخلفيات الداكنة
  static const Color textOnDark = Color(0xFFFFFFFF);
  
  // ========== تدرجات إضافية ==========
  
  /// تدرج النجاح
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// تدرج التحذير
  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, Color(0xFFFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// تدرج الخطأ
  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, Color(0xFFE53935)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// تدرج المعلومات
  static const LinearGradient infoGradient = LinearGradient(
    colors: [info, Color(0xFF2196F3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ========== أمثلة على الاستخدام ==========
  
  /// مثال على إنشاء زر بتدرج أساسي
  static Widget createPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      decoration: const BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: pureWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  /// مثال على إنشاء بطاقة بتدرج المياه
  static Widget createWaterCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: waterGradient,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
  
  /// مثال على إنشاء مؤشر حالة
  static Widget createStatusIndicator({
    required String status,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  
  // ========== ألوان الخريطة ==========
  
  /// ألوان مناطق الفيضانات على الخريطة
  static const Color floodZoneHigh = Color(0xFFD32F2F); // أحمر للخطر العالي
  static const Color floodZoneMedium = Color(0xFFFF9800); // برتقالي للخطر المتوسط
  static const Color floodZoneLow = Color(0xFFFFEB3B); // أصفر للخطر المنخفض
  static const Color floodZoneSafe = Color(0xFF4CAF50); // أخضر للأمان
  
  /// ألوان المؤشرات على الخريطة
  static const Color mapMarkerFlood = darkRed; // مؤشر الفيضان
  static const Color mapMarkerSafe = success; // مؤشر الأمان
  static const Color mapMarkerWarning = warning; // مؤشر التحذير
}

/// امتدادات مفيدة للألوان
extension ColorExtensions on Color {
  /// إنشاء نسخة أفتح من اللون
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
  
  /// إنشاء نسخة أغمق من اللون
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
  
  /// إنشاء نسخة شفافة من اللون
  Color withOpacity(double opacity) {
    return Color.fromRGBO(red, green, blue, opacity);
  }
}
