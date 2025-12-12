import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/phone_verification_screen.dart';

class ForgetPassController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController newPasswordController;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    phoneController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }

  void sendVerificationCode() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      Get.to(() => PhoneVerificationScreen(phoneNumber: phoneController.text));
    }
  }

  void goBack() {
    Get.back();
  }
}
