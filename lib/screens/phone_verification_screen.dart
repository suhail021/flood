import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google/controllers/verification_controller.dart';
import 'package:pinput/pinput.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? password;

  const PhoneVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    // Using tag to ensure unique controller if needed, or just standard put.
    // Since we might have multiple verification screens in stack (unlikely), standard put is fine.
    // However, if we resend and come back, we want fresh timer.
    // Get.put keeps the instance if in stack.
    // Logic: Registration -> Verification. Back -> Registration -> Verification.
    // If we go back, Verification is popped, controller disposed (if Get routes are used or auto-dispose).
    // Get.to uses generic routes, GetX usually auto-disposes controller if related view is removed from tree.
    // Inject controller
    final controller = Get.put(VerificationController(), permanent: false);

    // Pass user data to controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setUserData(fName: firstName, lName: lastName, pass: password);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          padding: EdgeInsets.only(right: 24),

          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 24, left: 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),

                // أيقونة التحقق
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.verified_user, size: 50),
                ),
                const SizedBox(height: 32),

                // عنوان الصفحة
                Text(
                  'verify_phone_title'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Text(
                  'verification_sent_to'.trParams({'phone': phoneNumber}),
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // حقل إدخال رمز التحقق
                Pinput(
                  length: 6,
                  controller: controller.otpController,
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 60,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 50,
                    height: 60,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  onCompleted: (pin) => controller.verifyCode(phoneNumber),
                ),
                const SizedBox(height: 40),

                // زر التحقق
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () => controller.verifyCode(phoneNumber),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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
                                'verify_button'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // زر إعادة الإرسال
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'didnt_receive_code'.tr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                    Obx(
                      () => TextButton(
                        onPressed:
                            controller.canResend.value
                                ? () => controller.resendCode(phoneNumber)
                                : null,
                        child: Text(
                          controller.canResend.value
                              ? 'resend'.tr
                              : 'resend_after'.trParams({
                                'seconds': '${controller.remainingTime.value}',
                              }),
                          style: TextStyle(
                            color:
                                controller.canResend.value
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                            fontSize: 16,
                            decoration:
                                controller.canResend.value
                                    ? TextDecoration.underline
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
