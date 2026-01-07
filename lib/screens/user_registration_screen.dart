import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/user_registration_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserRegistrationController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,

        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: const EdgeInsets.only(right: 24),
          onPressed: controller.goBack,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
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
                  child: Icon(
                    Icons.person_add,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'complete_registration'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Text(
                  'enter_personal_data'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // الاسم الأول
                CustomTextFormField(
                  controller: controller.firstNameController,
                  hintText: 'first_name'.tr,
                  prefixIcon: Icons.person,
                  validator:
                      (value) => value!.isEmpty ? 'enter_name_error'.tr : null,
                ),
                const SizedBox(height: 20),

                // الاسم الأخير
                CustomTextFormField(
                  controller: controller.lastNameController,
                  hintText: 'last_name'.tr,
                  prefixIcon: Icons.person_outline,
                  validator:
                      (value) => value!.isEmpty ? 'enter_name_error'.tr : null,
                ),
                const SizedBox(height: 20),

                // رقم الهاتف
                CustomTextFormField(
                  controller: controller.phoneController,
                  hintText: 'phone_number'.tr,
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
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
                const SizedBox(height: 20),
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
