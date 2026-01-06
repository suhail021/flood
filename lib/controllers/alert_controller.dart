import 'dart:async';
import 'package:get/get.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/services/notification_service.dart';
import 'package:google/models/critical_alert_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertController extends GetxController {
  final FloodService _floodService = FloodService();
  final NotificationService _notificationService = NotificationService();
  Timer? _timer;
  final RxBool hasAlerts = false.obs;
  final RxList<CriticalAlert> criticalAlerts = <CriticalAlert>[].obs;

  @override
  void onInit() {
    super.onInit();
    _startPolling();
  }

  void _startPolling() {
    // Initial fetch
    _checkAlerts();

    // Poll every 5 minutes
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _checkAlerts();
    });
  }

  Future<void> _checkAlerts() async {
    try {
      final response = await _floodService.getCriticalAlerts();

      hasAlerts.value = response.hasAlerts;

      if (response.hasAlerts && response.alerts != null) {
        // Collect all alerts
        final allAlerts = [
          ...response.alerts!.fromAi,
          ...response.alerts!.fromEmployees,
        ];

        criticalAlerts.assignAll(allAlerts);

        // Check for new alerts to notify
        for (var alert in allAlerts) {
          await _notifyIfNew(alert);
        }
      }
    } catch (e) {
      print('Error checking alerts: $e');
    }
  }

  Future<void> _notifyIfNew(CriticalAlert alert) async {
    final prefs = await SharedPreferences.getInstance();
    final notifiedKey = 'notified_alert_${alert.id}_${alert.lastUpdatedAt}';

    final hasNotified = prefs.getBool(notifiedKey) ?? false;

    if (!hasNotified) {
      await _notificationService.showNotification(
        alert.id,
        'تحذير فيضان حرج: ${alert.locationName}',
        '${alert.alertTypeName}. ${alert.timeRemaining}. يرجى الحذر!',
      );

      await prefs.setBool(notifiedKey, true);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
