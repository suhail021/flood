import 'package:get/get.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/screens/home_screen.dart';
import 'package:google/screens/phone_login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    // Wait for animation or artificial delay
    await Future.delayed(const Duration(seconds: 3));

    final UserPreferences userPrefs = UserPreferences();
    final String? token = await userPrefs.getToken();

    if (token != null && token.isNotEmpty) {
      Get.off(() => const HomeScreen());
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
