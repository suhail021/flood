import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/my_reports_controller.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyReportsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        centerTitle: true,

        title: Text('reports'.tr, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // مثال على بلاغ
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.report, color: Color(0xFF2C3E50)),
              ),
              title: const Text(
                'بلاغ سيول في شارع الزبيري',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              subtitle: Text(
                '${'date_sent'.tr}: 2025-09-01\n${'status'.tr}: ${'status_processing'.tr}',
                style: const TextStyle(color: Color(0xFF64748B)),
              ),
              onTap: () {
                // تفاصيل البلاغ
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check_circle, color: Colors.green),
              ),
              title: const Text(
                'تجمع مياه في حي الأصبحي',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              subtitle: Text(
                '${'date_sent'.tr}: 2025-08-28\n${'status'.tr}: ${'status_solved'.tr}',
                style: const TextStyle(color: Color(0xFF64748B)),
              ),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          // يمكن إضافة المزيد من البلاغات هنا
          Center(
            child: ElevatedButton.icon(
              onPressed: controller.goToReportFlood,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E50),
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
          ),
        ],
      ),
    );
  }
}
