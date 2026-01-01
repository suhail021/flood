import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/report_flood_controller.dart';

class FloodReportTypeSelector extends StatelessWidget {
  final ReportFloodController controller;

  const FloodReportTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      value: controller.selectedReportType.value,
                      hint: Text("choose_report_type".tr),
                      items: [
                        DropdownMenuItem(
                          value: "water",
                          child: Text("type_water_gathering".tr),
                        ),
                        DropdownMenuItem(
                          value: "drowning",
                          child: Text("type_drowning".tr),
                        ),
                        DropdownMenuItem(
                          value: "flood",
                          child: Text("type_flood".tr),
                        ),
                      ],
                      onChanged: controller.setReportType,
                    ),
                  ),
                ],
              ),
            ),

            if (controller.selectedReportType.value != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "${'report_type'.tr}: ${controller.selectedReportType.value == "water"
                      ? 'type_water_gathering'.tr
                      : controller.selectedReportType.value == "drowning"
                      ? 'type_drowning'.tr
                      : 'type_flood'.tr}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
