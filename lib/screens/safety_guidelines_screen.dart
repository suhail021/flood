import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/widgets/security_help_item.dart';
import 'package:google/screens/widgets/security_help_section.dart';
import 'package:google/screens/widgets/emergency_contacts_card.dart';

class SafetyGuidelinesScreen extends StatelessWidget {
  const SafetyGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(right: 24, left: 24),
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back_ios, size: 22),
        ),
        centerTitle: true,
        title: Text(
          'safety_guide'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecurityHelpSection(
              title: 'safety_guidelines'.tr,
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
          ],
        ),
      ),
    );
  }
}
