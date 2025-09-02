import 'package:flutter/material.dart';
import 'package:google/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));
    
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
    
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: slidingAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(
                    Icons.app_shortcut,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 4),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
              )),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
                )),
                child: const Text(
                  "تطبيقي الرائع",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 6),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
              )),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                )),
                child: const Text(
                  "تطبيق يجعل حياتك أفضل وأسهل",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 8),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
              )),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
                )),
                child: SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    value: null, // لجعل شريط التقدم متحرك
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}