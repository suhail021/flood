import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/services/auth_service.dart';
import 'package:google/screens/phone_forgetpass_verify_screen.dart';
import 'package:google/screens/phone_forgetpass_reset_screen.dart';
import 'package:google/screens/phone_login_screen.dart';

class ForgetPassController extends GetxController {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  late TextEditingController phoneController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  final RxBool isLoading = false.obs;
  String? resetToken;
  String? currentPhoneNumber; // Store phone number independently

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    // phoneController.dispose();
    // newPasswordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }

  // Step 1: Send OTP
  void sendOtp() async {
    if (phoneFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
      isLoading.value = true;
      currentPhoneNumber = phoneController.text; // Store in variable
      try {
        await _authService.forgotPasswordSendOtp(currentPhoneNumber!);
        // CustomToast.showSuccess('otp_sent_success'.tr);
        Get.to(
          () => PhoneForgetpassVerifyScreen(phoneNumber: currentPhoneNumber!),
        );
      } catch (e) {
        CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Step 2: Verify OTP
  void verifyOtp(String otp) async {
    if (currentPhoneNumber == null) return;

    FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
    isLoading.value = true;
    try {
      final response = await _authService.forgotPasswordVerifyOtp(
        currentPhoneNumber!, // Use stored variable
        otp,
      );

      // The API response structure: { success: true, message: ..., reset_token: "..." }
      if (response['reset_token'] != null) {
        resetToken = response['reset_token'];
        // CustomToast.showSuccess('otp_verified_success'.tr);
        Get.to(() => const PhoneForgetpassResetScreen());
      } else {
        CustomToast.showError('invalid_response_format'.tr);
      }
    } catch (e) {
      CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Step 3: Reset Password
  void resetPassword() async {
    if (resetFormKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        CustomToast.showError('passwords_not_match'.tr);
        return;
      }

      if (resetToken == null) {
        CustomToast.showError('session_expired'.tr);
        return;
      }

      FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
      isLoading.value = true;
      try {
        await _authService.resetPassword(
          resetToken!,
          newPasswordController.text,
        );
        CustomToast.showSuccess('password_reset_success'.tr);
        Get.offAll(() => const PhoneLoginScreen());
        CustomToast.showSuccess('password_reset_success'.tr);
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
