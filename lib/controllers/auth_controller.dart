import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/home_screen.dart';
import 'package:google/screens/phone_forgetpass_screen.dart';
import 'package:google/screens/phone_registration_screen.dart';

class AuthController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    autovalidateMode.value = AutovalidateMode.onUserInteraction;

    if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      Get.offAll(() => const HomeScreen());
    }
  }

  void goToForgotPassword() {
    Get.to(() => const PhoneForgetpassScreen());
  }

  void goToRegistration() {
    Get.to(() => PhoneRegistrationScreen());
  }
}
