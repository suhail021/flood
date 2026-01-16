import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google/controllers/forget_pass_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';

class PhoneForgetpassScreen extends StatelessWidget {
  const PhoneForgetpassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPassController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(right: 24, left: 24),
          onPressed: controller.goBack,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 24, left: 24),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار التطبيق
                  const SizedBox(height: 20),
                  Icon(
                    Icons.lock_reset,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),

                  // عنوان التطبيق
                  Text(
                    'change_password'.tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'enter_phone_new_pass'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),

                  // حقل إدخال رقم الهاتف
                  CustomTextFormField(
                    controller: controller.phoneController,
                    hintText: 'phone_number'.tr,
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_phone_error'.tr;
                      }
                      if (value.length < 9) {
                        return 'invalid_phone_error'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    hintText: 'new_password_hint'.tr,
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_password_error'.tr;
                      }
                      return null;
                    },
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
                                : controller.sendVerificationCode,
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
                                  'send_verification_code'.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
