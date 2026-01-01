import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/report_flood_controller.dart';
import 'package:google/core/widgets/custom_text_form_field.dart';
import 'package:google/screens/widgets/flood_report_header.dart';
import 'package:google/screens/widgets/flood_report_image_picker.dart';
import 'package:google/screens/widgets/flood_report_location_picker.dart';
import 'package:google/screens/widgets/flood_report_type_selector.dart';

class ReportFloodScreen extends StatelessWidget {
  const ReportFloodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportFloodController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'report_flood_title'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FloodReportHeader(),
              const SizedBox(height: 20),

              // حقل الوصف
              CustomTextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                hintText: 'report_desc_hint'.tr,
                prefixIcon: Icons.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'desc_required_error'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // اختيار الصورة
              FloodReportImagePicker(controller: controller),
              const SizedBox(height: 24),

              // اختيار الموقع
              FloodReportLocationPicker(controller: controller),
              const SizedBox(height: 24),

              // اختيار نوع البلاغ
              FloodReportTypeSelector(controller: controller),
              const SizedBox(height: 20),

              // زر إرسال البلاغ
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : controller.submitReport,
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
                              'submit_report'.tr,
                              style: TextStyle(
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
    );
  }
}
