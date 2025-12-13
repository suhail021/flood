import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/notifications_controller.dart';
import 'package:google/models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'notifications_title'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.markAllAsRead,
            icon: const Icon(Icons.done_all),
            tooltip: 'mark_all_read'.tr,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // إحصائيات سريعة
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'total_notifications'.tr,
                      '${controller.notifications.length}',
                      Icons.notifications,
                    ),
                    _buildStatItem(
                      'unread'.tr,
                      '${controller.notifications.where((n) => !n.isRead).length}',
                      Icons.mark_email_unread,
                    ),
                    _buildStatItem(
                      'today'.tr,
                      '${controller.notifications.where((n) => n.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 1)))).length}',
                      Icons.today,
                    ),
                  ],
                ),
              ),
            ),

            // قائمة الإشعارات
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = controller.notifications[index];
                      return _buildNotificationCard(notification, controller);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: const Color(0xFF2C3E50), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNotificationCard(
    NotificationItem notification,
    NotificationsController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              notification.isRead
                  ? const Color(0xFFE2E8F0)
                  : _getNotificationColor(notification.type).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getNotificationColor(notification.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: _getNotificationColor(notification.type),
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      notification.isRead ? FontWeight.normal : FontWeight.bold,
                  color:
                      notification.isRead
                          ? const Color(0xFF64748B)
                          : const Color(0xFF2C3E50),
                ),
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification.type),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              notification.message,
              style: TextStyle(
                fontSize: 14,
                color:
                    notification.isRead
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTimestamp(notification.timestamp),
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
        onTap: () => controller.markAsRead(notification.id),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              controller.deleteNotification(notification.id);
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('delete'.tr),
                    ],
                  ),
                ),
              ],
        ),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.alert:
        return Colors.red;
      case NotificationType.weather:
        return Colors.cyan;
      case NotificationType.system:
        return Colors.purple;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.info:
        return Icons.info;
      case NotificationType.alert:
        return Icons.notification_important;
      case NotificationType.weather:
        return Icons.cloud;
      case NotificationType.system:
        return Icons.settings;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now'.tr;
    } else if (difference.inMinutes < 60) {
      return 'since_minutes'.trParams({'minutes': '${difference.inMinutes}'});
    } else if (difference.inHours < 24) {
      return 'since_hours'.trParams({'hours': '${difference.inHours}'});
    } else {
      return 'since_days'.trParams({'days': '${difference.inDays}'});
    }
  }
}
