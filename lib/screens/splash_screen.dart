import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> logoSlideAnimation;
  late Animation<Offset> titleSlideAnimation;
  late Animation<Offset> subtitleSlideAnimation;
  late Animation<double> waveAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
    Get.put(SplashController());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // أنيمشن الشعار
    logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    );

    // أنيمشن العنوان الرئيسي
    titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // أنيمشن العنوان الفرعي
    subtitleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // أنيمشن الأمواج
    waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    // أنيمشن التلاشي
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC), // أبيض مزرق فاتح
              Color(0xFFE2E8F0), // رمادي فاتح جداً
              Color(0xFFCBD5E1), // رمادي فاتح
            ],
          ),
        ),
        child: Stack(
          children: [
            // تأثير الموجات
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: waveAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: WavePainter(waveAnimation.value),
                  );
                },
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الشعار
                  SlideTransition(
                    position: logoSlideAnimation,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(75),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.2),
                          //     blurRadius: 15,
                          //     offset: const Offset(0, 5),
                          //   ),
                          // ],
                        ),
                        child: Center(
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // العنوان الرئيسي
                  SlideTransition(
                    position: titleSlideAnimation,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Text(
                        'app_title_splash'.tr,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black12,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // العنوان الفرعي
                  SlideTransition(
                    position: subtitleSlideAnimation,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Text(
                        'app_subtitle'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // شريط التقدم
                  SlideTransition(
                    position: subtitleSlideAnimation,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: SizedBox(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const LinearProgressIndicator(
                            minHeight: 8,
                            backgroundColor: Color(0xFFE2E8F0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF2C3E50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// رسام مخصص لتأثير الموجات
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF94A3B8).withOpacity(0.2)
          ..style = PaintingStyle.fill;

    final path = Path();

    // الموجة الأولى
    path.moveTo(0, size.height * 0.8);

    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height * 0.8 +
            sin((i / size.width * 4 * 3.14) + (animationValue * 10)) * 20,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // الموجة الثانية (أكثر شفافية)
    final path2 = Path();
    final paint2 =
        Paint()
          ..color = const Color(0xFF94A3B8).withOpacity(0.1)
          ..style = PaintingStyle.fill;

    path2.moveTo(0, size.height * 0.85);

    for (double i = 0; i <= size.width; i++) {
      path2.lineTo(
        i,
        size.height * 0.85 +
            sin((i / size.width * 3 * 3.14) + (animationValue * 8)) * 15,
      );
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
