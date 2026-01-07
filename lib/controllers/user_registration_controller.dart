import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/services/auth_service.dart';
import 'package:google/screens/phone_verification_screen.dart';
import 'package:google/core/utils/custom_toast.dart';

class UserRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void completeRegistration() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        CustomToast.showError('passwords_do_not_match'.tr);
        return;
      }

      isLoading.value = true;
      try {
        final response = await _authService.sendOtp(
          phoneNumber: phoneController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          password: passwordController.text,
          type: 'register',
        );

        if (response['success'] == true) {
          Get.to(
            () => PhoneVerificationScreen(
              phoneNumber: phoneController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              password: passwordController.text,
            ),
          );
          CustomToast.showSuccess(
            response['message'] ?? 'OTP sent successfully',
          );
        }
      } catch (e) {
        CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
      } finally {
        isLoading.value = false;
      }
    }
  }

  void goBack() {
    Get.back();
  }
}
