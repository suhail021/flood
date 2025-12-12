import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/models/notification_model.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.assignAll([
      NotificationItem(
        id: '1',
        title: 'تحذير من السيول',
        message: 'احتمال حدوث سيول في منطقة صنعاء القديمة خلال الساعات القادمة',
        type: NotificationType.warning,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        title: 'تحديث حالة المنطقة',
        message:
            'تم تحديث مستوى الخطر في منطقة صنعاء الشرقية من متوسط إلى عالي',
        type: NotificationType.info,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      NotificationItem(
        id: '3',
        title: 'بلاغ جديد',
        message:
            'تم استلام بلاغ جديد عن وجود مياه راكدة في منطقة صنعاء الغربية',
        type: NotificationType.alert,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        title: 'تحديث الطقس',
        message: 'توقعات هطول أمطار غزيرة في صنعاء خلال اليومين القادمين',
        type: NotificationType.weather,
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: 'نظام التنبؤ',
        message: 'تم تحديث خوارزميات التنبؤ بالسيول لتحسين دقة التوقعات',
        type: NotificationType.system,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ]);
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = NotificationItem(
        id: notifications[index].id,
        title: notifications[index].title,
        message: notifications[index].message,
        type: notifications[index].type,
        timestamp: notifications[index].timestamp,
        isRead: true,
      );
    }
  }

  void markAllAsRead() {
    final updated =
        notifications.map((n) {
          if (!n.isRead) {
            return NotificationItem(
              id: n.id,
              title: n.title,
              message: n.message,
              type: n.type,
              timestamp: n.timestamp,
              isRead: true,
            );
          }
          return n;
        }).toList();
    notifications.assignAll(updated);

    Get.snackbar(
      'نجاح',
      'تم تحديد جميع الإشعارات كمقروءة',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
    Get.snackbar(
      'نجاح',
      'تم حذف الإشعار',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
