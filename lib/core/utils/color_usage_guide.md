# دليل استخدام نظام الألوان

## نظرة عامة
تم إنشاء نظام الألوان هذا بناءً على الشعار الأصلي للتطبيق، والذي يحتوي على:
- البني الداكن للمباني والحدود
- البيج الفاتح للخلفية والسماء  
- الأزرق المخضر للمياه/القناة
- الأحمر الداكن للدبوس/المؤشر
- الأبيض للنوافذ والنص

## الألوان الأساسية

### الألوان الرئيسية
```dart
AppColors.primaryBrown    // البني الداكن - اللون الأساسي
AppColors.lightBeige      // البيج الفاتح - الخلفية
AppColors.tealBlue        // الأزرق المخضر - الثانوي
AppColors.darkRed         // الأحمر الداكن - التحذيرات
AppColors.pureWhite       // الأبيض النقي - النصوص
```

### ألوان الحالة
```dart
AppColors.success         // أخضر للنجاح
AppColors.warning         // برتقالي للتحذير
AppColors.error           // أحمر للخطأ
AppColors.info            // أزرق للمعلومات
```

## التدرجات

### التدرجات الأساسية
```dart
AppColors.primaryGradient     // تدرج البني الأساسي
AppColors.waterGradient       // تدرج المياه/القناة
AppColors.backgroundGradient  // تدرج الخلفية الفاتح
```

### تدرجات الحالة
```dart
AppColors.successGradient     // تدرج النجاح
AppColors.warningGradient     // تدرج التحذير
AppColors.errorGradient       // تدرج الخطأ
AppColors.infoGradient        // تدرج المعلومات
```

## أمثلة على الاستخدام

### 1. إنشاء زر أساسي
```dart
AppColorPalette.createPrimaryButton(
  text: 'تسجيل الدخول',
  onPressed: () {
    // منطق الزر
  },
)
```

### 2. إنشاء بطاقة بتدرج المياه
```dart
AppColorPalette.createWaterCard(
  child: Text('معلومات الفيضان'),
  margin: EdgeInsets.all(16),
  padding: EdgeInsets.all(20),
)
```

### 3. إنشاء مؤشر حالة
```dart
AppColorPalette.createStatusIndicator(
  status: 'آمن',
  color: AppColors.success,
)
```

### 4. استخدام التدرجات مباشرة
```dart
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('محتوى البطاقة'),
)
```

### 5. استخدام ألوان الخريطة
```dart
// لون منطقة فيضان عالية الخطر
Color floodColor = AppColors.floodZoneHigh;

// لون منطقة آمنة
Color safeColor = AppColors.floodZoneSafe;
```

## نصائح التصميم

### 1. التباين
- استخدم `AppColors.textPrimary` للنصوص على الخلفيات الفاتحة
- استخدم `AppColors.pureWhite` للنصوص على الخلفيات الداكنة

### 2. التسلسل الهرمي
- استخدم `AppColors.primaryBrown` للعناصر الأكثر أهمية
- استخدم `AppColors.tealBlue` للعناصر الثانوية
- استخدم `AppColors.lightBeige` للخلفيات

### 3. الحالات
- استخدم `AppColors.success` للعمليات الناجحة
- استخدم `AppColors.warning` للتحذيرات
- استخدم `AppColors.error` للأخطاء والتنبيهات المهمة

### 4. الخريطة
- استخدم `AppColors.floodZoneHigh` للمناطق عالية الخطر
- استخدم `AppColors.floodZoneMedium` للمناطق متوسطة الخطر
- استخدم `AppColors.floodZoneLow` للمناطق منخفضة الخطر
- استخدم `AppColors.floodZoneSafe` للمناطق الآمنة

## التخصيص

### إنشاء تدرج مخصص
```dart
LinearGradient customGradient = LinearGradient(
  colors: [
    AppColors.primaryBrown,
    AppColors.tealBlue,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

### تعديل شفافية اللون
```dart
Color semiTransparent = AppColors.primaryBrown.withOpacity(0.5);
```

### إنشاء نسخة أفتح أو أغمق
```dart
Color lighter = AppColors.primaryBrown.lighten(0.2);
Color darker = AppColors.primaryBrown.darken(0.2);
```

## التوافق مع Material Design

تم تصميم نظام الألوان ليكون متوافقاً مع Material Design 3:
- استخدام `ColorScheme.fromSeed()` في الثيم
- دعم الوضع الليلي
- تدرجات متناسقة مع الألوان الأساسية

## الصيانة

عند إضافة ألوان جديدة:
1. أضف اللون إلى `AppColors` class
2. أضف تعليق يوضح الغرض من اللون
3. أضف مثال على الاستخدام إذا لزم الأمر
4. حدث هذا الدليل
