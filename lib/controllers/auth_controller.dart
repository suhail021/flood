import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/main_screen.dart';
import 'package:google/screens/phone_forgetpass_screen.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/models/user_model.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'package:google/screens/user_registration_screen.dart';
import 'package:google/services/auth_service.dart';
import 'package:google/core/utils/custom_toast.dart';

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

  final AuthService _authService = Get.put(AuthService());

  void login() async {
    autovalidateMode.value = AutovalidateMode.onUserInteraction;

    if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        final response = await _authService.login(
          phoneController.text,
          passwordController.text,
        );

        if (response['success'] == true) {
          // Parse user data
          final loginUser = UserModel.fromJson(response['user']);
          final String token = response['token'];

          // Save session
          final UserPreferences userPrefs = UserPreferences();
          await userPrefs.saveUser(loginUser);
          await userPrefs.saveToken(token);

          Get.offAll(() => const MainScreen());
        } else {
          CustomToast.showError(response['message'] ?? 'login_failed'.tr);
        }
      } catch (e) {
        CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
      } finally {
        isLoading.value = false;
      }
    }
  }

  void loginAsGuest() async {
    isLoading.value = true;
    try {
      // Create a guest user model
      final guestUser = UserModel(
        id: 0,
        name: 'Guest',
        phoneNumber: '',
        role: 'guest',
      );

      // Save guest session
      final UserPreferences userPrefs = UserPreferences();
      await userPrefs.saveUser(guestUser);
      // We might not need a token for guest, or we can save a dummy one if needed for checks
      await userPrefs.saveToken('guest_token');

      Get.offAll(() => const MainScreen());

      CustomToast.showSuccess('login_success'.tr); // Or specific guest welcome
    } catch (e) {
      CustomToast.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToForgotPassword() {
    Get.to(() => const PhoneForgetpassScreen());
  }

  void goToRegistration() {
    Get.to(() => const UserRegistrationScreen());
  }

  void logout() async {
    final UserPreferences userPrefs = UserPreferences();
    await userPrefs.clearSession();
    Get.offAll(() => const PhoneLoginScreen());
  }
}
