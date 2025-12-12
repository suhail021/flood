import 'package:get/get.dart';
import 'package:google/screens/report_flood_screen.dart';

class MyReportsController extends GetxController {
  // Can add list of reports here in future

  void goToReportFlood() {
    Get.to(() => const ReportFloodScreen());
  }
}
