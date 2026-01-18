import 'package:get/get.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/screens/main_screen.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    checkLoginStatus();
  }

  void requestPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  void checkLoginStatus() async {
    // Wait for animation or artificial delay
    await Future.delayed(const Duration(seconds: 3));

    final UserPreferences userPrefs = UserPreferences();
    final String? token = await userPrefs.getToken();

    if (token != null && token.isNotEmpty) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => const PhoneLoginScreen());
    }
  }

  /*
  void navigateToPhoneLogin() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const PhoneLoginScreen());
    });
  }
*/
}
