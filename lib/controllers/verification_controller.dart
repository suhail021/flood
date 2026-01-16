import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/main_screen.dart';
import 'package:google/services/auth_service.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/models/user_model.dart';
import 'dart:async';

class VerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxInt remainingTime = 5.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Timer will be started via addPostFrameCallback in the screen
  }

  @override
  void onClose() {
    _timer?.cancel();
    // otpController.dispose();
    super.onClose();
  }

  void startTimer() {
    remainingTime.value = 30;
    canResend.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime.value--;
      print('⏳ Timer tick: ${remainingTime.value}');

      if (remainingTime.value <= 0) {
        remainingTime.value = 0;
        canResend.value = true;
        timer.cancel();
        print('✅ Timer finished');
      }
    });
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
      CustomToast.showError('enter_valid_otp'.tr);
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
        type: 'register',
      );

      print('✅ Verification Response: $response');

      if (response['success'] == true) {
        // إخفاء لوحة المفاتيح
        FocusManager.instance.primaryFocus?.unfocus();

        // حفظ التوكن أولاً
        if (response['token'] != null &&
            response['token'].toString().isNotEmpty) {
          await _userPreferences.saveToken(response['token']);
          print('✅ Token saved: ${response['token']}');
        } else {
          print('⚠️ No token received');
        }

        // حفظ بيانات المستخدم
        if (response['user'] != null) {
          try {
            final user = UserModel.fromJson(response['user']);
            await _userPreferences.saveUser(user);
            print('✅ User saved: ${user.name}');
          } catch (e) {
            print('❌ Error saving user: $e');
          }
        } else {
          print('⚠️ No user data received');
        }

        // عرض رسالة النجاح
        CustomToast.showSuccess(
          response['message'] ?? 'registration_success'.tr,
        );

        // تأخير قصير لضمان ظهور الرسالة
        await Future.delayed(const Duration(milliseconds: 800));

        // الانتقال إلى الشاشة الرئيسية وحذف جميع الشاشات السابقة
        Get.offAll(() => const MainScreen());
      } else {
        CustomToast.showError(response['message'] ?? 'verification_failed'.tr);
      }
    } catch (e) {
      print('❌ Verification Error: $e');
      CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void resendCode(String phoneNumber) async {
    if (!canResend.value) return;

    canResend.value = false;

    try {
      await _authService.resendOtp(phoneNumber: phoneNumber, type: 'register');

      startTimer();
      CustomToast.showSuccess('code_resent_success'.tr);
    } catch (e) {
      canResend.value = true;
      CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
