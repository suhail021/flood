import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyContactsCard extends StatelessWidget {
  const EmergencyContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color:
          isDark
              ? Colors.red.shade900.withOpacity(0.2)
              : const Color(0xFFFEF2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.red.shade800 : const Color(0xFFFECACA),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.emergency, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'emergency_contacts'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildEmergencyContact('civil_defense'.tr, '191'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact('police'.tr, '199'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact('ambulance'.tr, '195'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact('traffic_accidents'.tr, '194'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Colors.red.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: isDark ? Colors.white : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      number,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
