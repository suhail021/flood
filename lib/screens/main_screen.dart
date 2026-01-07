import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/main_controller.dart';
import 'package:google/screens/home_screen.dart';
import 'package:google/screens/my_reports_screen.dart';
import 'package:google/screens/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    final List<Widget> screens = [
      const HomeScreen(),
      const MyReportsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: controller.changeIndex,
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
            indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'home'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.assignment_outlined),
                selectedIcon: Icon(
                  Icons.assignment,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'reports'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
