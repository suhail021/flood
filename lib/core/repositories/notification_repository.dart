import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google/models/notification_model.dart';
import 'package:google/services/flood_service.dart';

class NotificationRepository {
  final FloodService _floodService;
  static const String _storageKey = 'saved_notifications';

  NotificationRepository(this._floodService);

  Future<List<NotificationItem>> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Load local notifications
    List<NotificationItem> localNotifications = [];
    final String? storedData = prefs.getString(_storageKey);
    if (storedData != null) {
      final List<dynamic> decoded = json.decode(storedData);
      localNotifications =
          decoded.map((e) => NotificationItem.fromJson(e)).toList();
    }

    // 2. Fetch API alerts
    try {
      final criticalAlertResponse = await _floodService.getCriticalAlerts();
      if (criticalAlertResponse.success &&
          criticalAlertResponse.alerts != null) {
        final apiAlerts = [
          ...criticalAlertResponse.alerts!.fromAi,
          ...criticalAlertResponse.alerts!.fromEmployees,
        ];

        // 3. Merge and sync
        for (var alert in apiAlerts) {
          final String alertId = alert.id.toString();

          // Check if this alert already exists locally
          final existingIndex = localNotifications.indexWhere(
            (n) => n.id == alertId,
          );

          if (existingIndex == -1) {
            // New alert from API
            localNotifications.add(
              NotificationItem(
                id: alertId,
                title: 'تنبيه: ${alert.alertTypeName}',
                message:
                    'الموقع: ${alert.locationName}\nمستوى الخطر: ${alert.riskLevel}',
                type: NotificationType.alert, // You might map specific types
                timestamp:
                    DateTime.tryParse(alert.firstDetectedAt) ?? DateTime.now(),
                isRead: false,
                source: 'api',
              ),
            );
          } else {
            // Update logic if needed, but preserve isRead
            // For now, we assume ID is unique and immutable content for simplicity,
            // or updates are treated as same ID.
          }
        }
      }
    } catch (e) {
      // Handle API error (maybe rely on cached data only)
      print('Error fetching remote notifications: $e');
    }

    // Sort by timestamp descending
    localNotifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // 4. Save updated list
    await saveNotifications(localNotifications);

    return localNotifications;
  }

  Future<void> saveNotifications(List<NotificationItem> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(
      notifications.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> markAsRead(String id) async {
    // We update local storage directly

    final prefs = await SharedPreferences.getInstance();
    final String? storedData = prefs.getString(_storageKey);
    if (storedData != null) {
      final List<dynamic> decoded = json.decode(storedData);
      List<NotificationItem> items =
          decoded.map((e) => NotificationItem.fromJson(e)).toList();

      final index = items.indexWhere((element) => element.id == id);
      if (index != -1) {
        items[index] = NotificationItem(
          id: items[index].id,
          title: items[index].title,
          message: items[index].message,
          type: items[index].type,
          timestamp: items[index].timestamp,
          isRead: true,
          source: items[index].source,
        );
        await saveNotifications(items);
      }
    }
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
