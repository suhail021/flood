import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google/controllers/auth_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 24, left: 24),
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار التطبيق
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // عنوان التطبيق
                  Text(
                    'login'.tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // حقل إدخال رقم الهاتف
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.phoneController,
                      hintText: 'phone_number'.tr,
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: controller.autovalidateMode.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_phone_error'.tr;
                        }
                        if (value.length < 9) {
                          return 'phone_length_error'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      hintText: 'password_hint'.tr,
                      prefixIcon: Icons.lock,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: controller.autovalidateMode.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_password_error'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  // زر إرسال رمز التحقق
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          elevation: 0,
                        ),
                        child:
                            controller.isLoading.value
                                ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                                : Text(
                                  'login'.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // زر الاتصال المباشر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: controller.goToForgotPassword,
                        child: Text(
                          'forgot_password_question'.tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToRegistration,
                        child: Text(
                          'create_account'.tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // زر الدخول كزائر
                  TextButton.icon(
                    onPressed: controller.loginAsGuest,
                    icon: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    label: Text(
                      'continue_as_guest'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
