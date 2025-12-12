import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/home_screen.dart';

class UserRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void completeRegistration() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      // Simulate registration
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      Get.offAll(() => const HomeScreen());
    }
  }

  void goBack() {
    Get.back();
  }
}
