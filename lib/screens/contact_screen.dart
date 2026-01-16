import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/security_help_controller.dart';
import 'package:google/screens/widgets/contact_us_card.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecurityHelpController());

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
          'contact_support'.tr,
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
          children: [ContactUsCard(controller: controller)],
        ),
      ),
    );
  }
}
