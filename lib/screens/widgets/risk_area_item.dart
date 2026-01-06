import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google/controllers/home_controller.dart';

class RiskAreaItem extends StatelessWidget {
  final HomeController controller;
  final String name;
  final String risk;
  final Color color;
  final double probability;
  final LatLng targetLocation;

  const RiskAreaItem({
    super.key,
    required this.controller,
    required this.name,
    required this.risk,
    required this.color,
    required this.probability,
    required this.targetLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.animateToLocation(targetLocation),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(_getRiskIcon(risk), color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'risk_level'.tr}: $risk',
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   '${'probability'.tr}: ${(probability * 100).toInt()}%',
                  //   style: const TextStyle(fontSize: 12, color: Colors.grey),
                  // ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: probability,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(probability * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRiskIcon(String risk) {
    switch (risk) {
      case 'risk_low':
        return Icons.check_circle;
      case 'risk_medium':
        return Icons.info;
      case 'risk_high':
        return Icons.warning;
      case 'risk_critical':
        return Icons.dangerous;
      default:
        return Icons.help;
    }
  }
}
