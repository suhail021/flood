import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/alert_controller.dart';
import 'package:google/screens/widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AlertController controller = Get.find<AlertController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات والتحذيرات'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.notificationHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'لا توجد إشعارات حالياً',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.notificationHistory.length,
          padding: const EdgeInsets.only(top: 16, bottom: 20),
          itemBuilder: (context, index) {
            final alert = controller.notificationHistory[index];
            return NotificationCard(alert: alert);
          },
        );
      }),
    );
  }
}
