import 'package:get/get.dart';
import 'package:google/screens/report_flood_screen.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/models/report_model.dart';

class MyReportsController extends GetxController {
  final FloodService _floodService = FloodService();
  final RxList<ReportModel> myReports = <ReportModel>[].obs;
  final RxBool isLoading = false.obs;

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
      Get.snackbar('Error', 'Failed to fetch reports');
    } finally {
      isLoading.value = false;
    }
  }

  void goToReportFlood() {
    Get.to(() => const ReportFloodScreen());
  }
}
