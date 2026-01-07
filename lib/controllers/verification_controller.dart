import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/main_screen.dart';
import 'package:google/services/auth_service.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/utils/user_preferences.dart';

class VerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxInt remainingTime = 60.obs;
  final RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    // otpController.dispose(); // Commenting out to prevent 'used after disposed' error during navigation
    super.onClose();
  }

  void startTimer() {
    remainingTime.value = 120;
    canResend.value = false;
    _tick();
  }

  void _tick() {
    if (remainingTime.value > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        // Check if controller is still alive
        if (!isClosed) {
          remainingTime.value--;
          _tick();
        }
      });
    } else {
      canResend.value = true;
    }
  }

  final AuthService _authService = AuthService();
  final UserPreferences _userPreferences = UserPreferences();
  final RxString? firstName = RxString('');
  final RxString? lastName = RxString('');
  final RxString? password = RxString('');

  void setUserData({String? fName, String? lName, String? pass}) {
    firstName?.value = fName ?? '';
    lastName?.value = lName ?? '';
    password?.value = pass ?? '';
  }

  void verifyCode(String phoneNumber) async {
    final otp = otpController.text;

    if (otp.length != 6) {
      CustomToast.showError('Enter valid OTP');
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authService.verifyOtp(
        phoneNumber,
        otp,
        firstName: firstName?.value,
        lastName: lastName?.value,
        password: password?.value,
      );

      if (response['success'] == true) {
        // Unfocus to close keyboard
        FocusManager.instance.primaryFocus?.unfocus();

        // Wait to ensure UI handles unfocus before navigation
        await Future.delayed(const Duration(milliseconds: 500));

        if (response['token'] != null) {
          await _userPreferences.saveToken(response['token']);
        }

        // Navigate to home - GetX will handle controller disposal
        Get.offAll(() => const MainScreen());

        CustomToast.showSuccess('Verified Successfully');
      }
    } catch (e) {
      CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void resendCode(String phoneNumber) async {
    canResend.value = false;
    // Simulate resend
    await Future.delayed(const Duration(seconds: 1));

    startTimer();
    Get.snackbar(
      'نجاح',
      'تم إعادة إرسال رمز التحقق',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
