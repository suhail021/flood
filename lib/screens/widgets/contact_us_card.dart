import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/security_help_controller.dart';

class ContactUsCard extends StatelessWidget {
  final SecurityHelpController controller;

  const ContactUsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.support_agent, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'contact_us'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              'email'.tr,
              'support@floodapp.gov.sa',
              Icons.email,
              onTap: () => controller.sendEmail('support@floodapp.gov.sa'),
            ),
            _buildContactItem(
              'tech_support'.tr,
              '8001234567',
              Icons.phone,
              onTap: () => controller.makePhoneCall('8001234567'),
            ),
            _buildContactItem(
              'working_hours'.tr,
              'working_hours_val'.tr,
              Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    String title,
    String content,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.green, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                          decoration:
                              onTap != null
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                          decorationColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
