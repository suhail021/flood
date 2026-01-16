import 'dart:async';
import 'package:get/get.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'package:google/screens/report_flood_screen.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/models/report_model.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/screens/notifications_screen.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google/controllers/auth_controller.dart';

class MyReportsController extends GetxController {
  final FloodService _floodService = FloodService();
  final RxList<ReportModel> myReports = <ReportModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedStatus = 'all'.obs;
  Timer? _timer;

  List<ReportModel> get filteredReports {
    if (selectedStatus.value == 'all') {
      return myReports;
    }
    return myReports.where((report) {
      final status = report.status.toLowerCase().trim();
      final statusName = report.statusName?.toLowerCase().trim() ?? '';
      final filter = selectedStatus.value.toLowerCase();

      if (filter == 'solved') {
        return status == 'processed' ||
            status == 'solved' ||
            status == 'completed' ||
            statusName.contains('solved') ||
            statusName.contains('processed');
      }

      if (filter == 'processing') {
        return status == 'under_review' ||
            status == 'processing' ||
            status == 'in_progress' ||
            statusName.contains('processing');
      }

      return status == filter;
    }).toList();
  }

  void setFilter(String status) {
    selectedStatus.value = status;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyReports();
    // Start periodic update every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchMyReports(isBackground: true);
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchMyReports({bool isBackground = false}) async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final user = await userPrefs.getUser();

      // Don't fetch if user is guest or null (though null might need login)
      if (user == null || user.role == 'guest') {
        if (!isBackground) isLoading.value = false;
        return;
      }

      if (!isBackground) {
        isLoading.value = true;
      }
      final reports = await _floodService.getMyReports();
      myReports.assignAll(reports);
    } catch (e) {
      if (!isBackground) {
        if (e is Failure) {
          CustomToast.showError(e.errMessage);
        } else {
          CustomToast.showError('Failed to fetch reports');
        }
      }
    } finally {
      if (!isBackground) {
        isLoading.value = false;
      }
    }
  }

  Future<void> goToReportFlood() async {
    final UserPreferences userPrefs = UserPreferences();
    final user = await userPrefs.getUser();

    if (user != null && user.role == 'guest') {
      Get.defaultDialog(
        title: 'guest_login_required_title'.tr,
        middleText: 'guest_login_required_message'.tr,
        textConfirm: 'login_now'.tr,
        textCancel: 'cancel'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close dialog
          if (Get.isRegistered<AuthController>()) {
            Get.find<AuthController>().logout();
          } else {
            // Fallback if controller is disposed
            final UserPreferences userPrefs = UserPreferences();
            userPrefs.clearSession();
            Get.offAll(
              () => const PhoneLoginScreen(),
            ); // Need to ensure import is present or add it
          }
        },
      );
    } else {
      Get.to(() => const ReportFloodScreen());
    }
  }

  void goToNotifications() {
    Get.to(() => const NotificationsScreen());
  }
}
