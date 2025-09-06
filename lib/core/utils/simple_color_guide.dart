import 'package:flutter/material.dart';
import 'package:google/constants.dart';

/// دليل بسيط لاستخدام اللونين الأساسيين للتطبيق
/// 
/// اللون الأساسي: البني الداكن (من المباني في الشعار)
/// اللون الثانوي: الأزرق المخضر (من المياه/القناة في الشعار)
class SimpleColorGuide {
  
  // ========== اللونان الأساسيان ==========
  
  /// البني الداكن - اللون الأساسي للتطبيق
  /// يستخدم للأزرار الرئيسية، شريط التطبيق، والعناصر المهمة
  static const Color primary = AppColors.primaryBrown;
  
  /// الأزرق المخضر - اللون الثانوي للتطبيق  
  /// يستخدم للعناصر الثانوية، الروابط، والتركيز
  static const Color secondary = AppColors.tealBlue;
  
  // ========== أمثلة على الاستخدام ==========
  
  /// إنشاء زر أساسي باللون البني الداكن
  static Widget createPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: AppColors.pureWhite,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
  
  /// إنشاء زر ثانوي بالأزرق المخضر
  static Widget createSecondaryButton({
    required String text,
    required VoidCallback onPressed,
    EdgeInsetsGeometry? padding,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: secondary,
        side: const BorderSide(color: secondary, width: 2),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
  
  /// إنشاء بطاقة باللون الأساسي
  static Widget createPrimaryCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
  
  /// إنشاء بطاقة باللون الثانوي
  static Widget createSecondaryCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: secondary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
  
  /// إنشاء مؤشر حالة باللون الأساسي
  static Widget createPrimaryIndicator({
    required String text,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  
  /// إنشاء مؤشر حالة باللون الثانوي
  static Widget createSecondaryIndicator({
    required String text,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  
  /// إنشاء تدرج من اللون الأساسي إلى الثانوي
  static Widget createGradientContainer({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
  
  // ========== أمثلة على الاستخدام في الواجهة ==========
  
  /// مثال على صفحة تستخدم اللونين الأساسيين
  static Widget createExamplePage() {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: AppColors.pureWhite,
        title: const Text('مثال على استخدام الألوان'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // زر أساسي
            createPrimaryButton(
              text: 'زر أساسي (بني داكن)',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            
            // زر ثانوي
            createSecondaryButton(
              text: 'زر ثانوي (أزرق مخضر)',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            
            // بطاقة أساسية
            createPrimaryCard(
              child: const Text(
                'بطاقة باللون الأساسي',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // بطاقة ثانوية
            createSecondaryCard(
              child: const Text(
                'بطاقة باللون الثانوي',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // مؤشرات الحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createPrimaryIndicator(text: 'أساسي'),
                createSecondaryIndicator(text: 'ثانوي'),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // تدرج
            createGradientContainer(
              child: const Text(
                'تدرج من الأساسي إلى الثانوي',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
