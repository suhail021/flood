import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurityHelpController extends GetxController {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<void> sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(launchUri);
  }

  void sendFeedback() {
    Get.defaultDialog(
      title: 'send_feedback'.tr,
      content: Text('feature_under_development'.tr),
      textConfirm: 'ok'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
