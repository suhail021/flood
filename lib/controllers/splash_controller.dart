import 'package:get/get.dart';
import 'package:google/screens/phone_login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToPhoneLogin();
  }

  void navigateToPhoneLogin() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const PhoneLoginScreen());
    });
  }
}
