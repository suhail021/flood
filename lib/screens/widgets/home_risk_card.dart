import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google/controllers/home_controller.dart';
import 'package:google/models/risk_area_model.dart';
import 'risk_area_item.dart';
import 'shimmer_helper.dart';

class HomeRiskCard extends StatelessWidget {
  final HomeController controller;

  const HomeRiskCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'potential_flood_areas'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: controller.goToReportFlood,
                child: Text(
                  'submit_report'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.criticalAlerts.isEmpty &&
                  controller.aiPredictions.isEmpty) {
                return const RiskCardShimmer();
              }

              if (controller.allRisks.isEmpty) {
                return Center(
                  child: Text(
                    'no_risks_found'.tr,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: controller.allRisks.length,
                itemBuilder: (context, index) {
                  final item = controller.allRisks[index];
                  if (item is ManualAlert) {
                    return RiskAreaItem(
                      controller: controller,
                      name: item.locationName,
                      risk: _mapRiskLevel(item.riskLevel),
                      color: Colors.red,
                      probability: item.riskLevel / 100.0,
                      targetLocation: LatLng(item.latitude, item.longitude),
                    );
                  } else if (item is AiPrediction) {
                    return RiskAreaItem(
                      controller: controller,
                      name: item.locationName,
                      risk: _mapRiskLevel(item.riskLevel),
                      color: _parseColor(item.riskColor),
                      probability: item.riskLevel / 100.0,
                      targetLocation: LatLng(item.latitude, item.longitude),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String _mapRiskLevel(int level) {
    if (level >= 75) return 'risk_critical'.tr;
    if (level >= 50) return 'risk_high'.tr;
    if (level >= 25) return 'risk_medium'.tr;
    return 'risk_low'.tr;
  }

  Color _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return Colors.green;
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (_) {
      return Colors.green;
    }
  }
}
