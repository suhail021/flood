import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/user_registration_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';

class UserRegistrationScreen extends StatelessWidget {
  final String phoneNumber;

  const UserRegistrationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserRegistrationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        centerTitle: true,

        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: const EdgeInsets.only(right: 24),
          onPressed: controller.goBack,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2C3E50),
            size: 28,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 50,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'complete_registration'.tr,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Text(
                  'enter_personal_data'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // الاسم
                CustomTextFormField(
                  controller: controller.nameController,
                  hintText: 'full_name_hint'.tr,
                  prefixIcon: Icons.person,
                  validator:
                      (value) => value!.isEmpty ? 'enter_name_error'.tr : null,
                ),
                const SizedBox(height: 20),

                // العنوان (كلمة السر)
                CustomTextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  hintText: 'password_hint'.tr,
                  prefixIcon: Icons.lock,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'enter_password_error'.tr : null,
                ),

                const SizedBox(height: 20),
                CustomTextFormField(
                  obscureText: true,
                  controller: controller.confirmPasswordController,
                  hintText: 'confirm_password_hint'.tr,
                  prefixIcon: Icons.lock_outline,
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? 'enter_confirm_password_error'.tr
                              : null,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 15),

                // المدينة
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.completeRegistration,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
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
                                'complete_registration'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
