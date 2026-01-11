import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/models/notification_model.dart';
import 'package:google/core/repositories/notification_repository.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/core/utils/custom_toast.dart';

class NotificationsController extends GetxController {
  final NotificationRepository _repository = NotificationRepository(
    Get.find<FloodService>(),
  );

  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final loaded = await _repository.fetchNotifications();
      notifications.assignAll(loaded);
    } catch (e) {
      CustomToast.showError('فشل في تحميل الإشعارات');
    }
  }

  Future<void> markAsRead(String id) async {
    await _repository.markAsRead(id);
    // Update local state to reflect change immediately
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final item = notifications[index];
      notifications[index] = NotificationItem(
        id: item.id,
        title: item.title,
        message: item.message,
        type: item.type,
        timestamp: item.timestamp,
        isRead: true,
        source: item.source,
      );
    }
    update(); // Force UI update if needed
  }

  Future<void> markAllAsRead() async {
    // This requires a batch update in repo, adding a helper there would be better
    // For now, doing it in memory and saving all
    final updated =
        notifications.map((n) {
          return NotificationItem(
            id: n.id,
            title: n.title,
            message: n.message,
            type: n.type,
            timestamp: n.timestamp,
            isRead: true,
            source: n.source,
          );
        }).toList();

    notifications.assignAll(updated);
    await _repository.saveNotifications(updated);

    CustomToast.showSuccess('تم تحديد جميع الإشعارات كمقروءة');
  }

  Future<void> deleteNotification(String id) async {
    notifications.removeWhere((n) => n.id == id);
    await _repository.saveNotifications(notifications.toList());

    CustomToast.showSuccess('تم حذف الإشعار');
  }
}
