import 'package:get/get.dart';
import 'package:google/screens/report_flood_screen.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/models/report_model.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/screens/notifications_screen.dart';

class MyReportsController extends GetxController {
  final FloodService _floodService = FloodService();
  final RxList<ReportModel> myReports = <ReportModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedStatus = 'all'.obs;

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
  }

  Future<void> fetchMyReports() async {
    try {
      isLoading.value = true;
      final reports = await _floodService.getMyReports();
      myReports.assignAll(reports);
    } catch (e) {
      if (e is Failure) {
        CustomToast.showError(e.errMessage);
      } else {
        CustomToast.showError('Failed to fetch reports');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void goToReportFlood() {
    Get.to(() => const ReportFloodScreen());
  }

  void goToNotifications() {
    Get.to(() => const NotificationsScreen());
  }
}
