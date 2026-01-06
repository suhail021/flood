import 'package:flutter/material.dart';
import 'package:google/models/critical_alert_model.dart';

class NotificationCard extends StatelessWidget {
  final CriticalAlert alert;

  const NotificationCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    // Determine color based on risk level
    Color riskColor;
    Color backgroundColor;
    IconData iconData;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (alert.riskLevel >= 70) {
      riskColor =
          isDarkMode ? const Color(0xFFEF5350) : const Color(0xFFD32F2F);
      backgroundColor =
          isDarkMode ? const Color(0xFF3E2723) : const Color(0xFFFFEBEE);
      iconData = Icons.warning_rounded;
    } else if (alert.riskLevel >= 40) {
      riskColor =
          isDarkMode ? const Color(0xFFFFB74D) : const Color(0xFFF57C00);
      backgroundColor =
          isDarkMode ? const Color(0xFF3E2723) : const Color(0xFFFFF3E0);
      iconData = Icons.info_outline_rounded;
    } else {
      riskColor =
          isDarkMode ? const Color(0xFF66BB6A) : const Color(0xFF388E3C);
      backgroundColor =
          isDarkMode ? const Color(0xFF1B5E20) : const Color(0xFFE8F5E9);
      iconData = Icons.check_circle_outline_rounded;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white10
                  : Colors.grey.shade200,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: riskColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.locationName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          alert.alertTypeName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: riskColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${alert.riskLevel}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        alert.timeRemaining,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Text(
                    alert.lastUpdatedAt,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
