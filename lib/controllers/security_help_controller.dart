import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityHelpController extends GetxController {
  void sendFeedback() {
    Get.defaultDialog(
      title: 'إرسال ملاحظات',
      content: const Text('هذه الميزة قيد التطوير حالياً.'),
      textConfirm: 'حسناً',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
