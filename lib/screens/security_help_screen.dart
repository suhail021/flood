import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/security_help_controller.dart';
import 'package:google/screens/widgets/contact_us_card.dart';
import 'package:google/screens/widgets/emergency_contacts_card.dart';
import 'package:google/screens/widgets/faq_section.dart';
import 'package:google/screens/widgets/security_help_item.dart';
import 'package:google/screens/widgets/security_help_section.dart';

class SecurityHelpScreen extends StatelessWidget {
  const SecurityHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecurityHelpController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(right: 24, left: 24),
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back_ios, size: 22),
        ),
        title: Text(
          'help_support_title'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecurityHelpSection(
              title: 'how_to_use'.tr,
              items: [
                SecurityHelpItem(
                  title: 'alerts_notifications'.tr,
                  content: 'alerts_desc'.tr,
                  icon: Icons.notifications_active,
                ),
                SecurityHelpItem(
                  title: 'risk_map'.tr,
                  content: 'risk_map_desc'.tr,
                  icon: Icons.map,
                ),
                SecurityHelpItem(
                  title: 'safety_guidelines'.tr,
                  content: 'safety_guidelines_desc'.tr,
                  icon: Icons.health_and_safety,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SecurityHelpSection(
              title: 'emergency_procedures'.tr,
              items: [
                SecurityHelpItem(
                  title: 'before_flood'.tr,
                  content: 'before_flood_desc'.tr,
                  icon: Icons.access_time,
                ),
                SecurityHelpItem(
                  title: 'during_flood'.tr,
                  content: 'during_flood_desc'.tr,
                  icon: Icons.warning,
                ),
                SecurityHelpItem(
                  title: 'after_flood'.tr,
                  content: 'after_flood_desc'.tr,
                  icon: Icons.restore,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const EmergencyContactsCard(),
            const SizedBox(height: 24),
            const FAQSection(),
            const SizedBox(height: 24),
            ContactUsCard(controller: controller),
          ],
        ),
      ),
    );
  }
}
