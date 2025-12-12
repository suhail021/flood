import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/user_registration_screen.dart';

class VerificationController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
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
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    remainingTime.value = 60;
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

  void verifyCode(String phoneNumber) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      // Simulate verification
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      Get.off(() => UserRegistrationScreen(phoneNumber: phoneNumber));
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

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
  }
}
