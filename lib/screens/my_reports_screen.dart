import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/my_reports_controller.dart';
import 'package:google/models/report_model.dart';
import 'package:google/screens/widgets/shimmer_helper.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyReportsController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'reports'.tr,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const ReportCardShimmer();
        }

        if (controller.myReports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'no_reports_yet'.tr,
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: controller.goToReportFlood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: Text('add_new_report'.tr),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.myReports.length,
          itemBuilder: (context, index) {
            final report = controller.myReports[index];
            return _buildReportCard(context, report);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.goToReportFlood,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'add_new_report'.tr,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, ReportModel report) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color statusColor;
    String statusText = '';

    if (report.statusName != null && report.statusName!.isNotEmpty) {
      statusText = report.statusName!;
    } else {
      statusText = report.status;
    }

    if (report.statusColor != null && report.statusColor!.isNotEmpty) {
      try {
        statusColor = Color(
          int.parse(report.statusColor!.replaceFirst('#', '0xFF')),
        );
      } catch (_) {
        statusColor = Colors.grey;
      }
    } else {
      switch (report.status.toLowerCase()) {
        case 'pending':
          statusColor = Colors.orange;
          break;
        case 'processed':
        case 'processing':
          statusColor = Colors.blue;
          break;
        case 'solved':
        case 'completed':
          statusColor = Colors.green;
          break;
        case 'rejected':
          statusColor = Colors.red;
          break;
        default:
          statusColor = Colors.grey;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDarkMode ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: _buildLeadingIcon(context, statusColor),
            title: Text(
              report.description.isNotEmpty
                  ? report.description
                  : 'report_no_desc'.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        report.addedAt,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.assignment, color: color),
    );
  }
}
