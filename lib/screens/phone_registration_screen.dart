import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google/controllers/registration_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,

        elevation: 0,
        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: const EdgeInsets.only(right: 24, left: 24),
          onPressed: controller.goBack,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2.0, right: 24, left: 24),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // شعار التطبيق
                Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                  'create_account'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                Text(
                  'enter_phone_to_continue'.tr,
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
                      return 'phone_length_error'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // زر إرسال رمز التحقق
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.register,
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
                // زر الاتصال المباشر
                TextButton(
                  onPressed: controller.goBack,
                  child: Text(
                    'already_have_account'.tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
