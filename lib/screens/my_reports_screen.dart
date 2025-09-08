import 'package:flutter/material.dart';
import 'package:google/screens/report_flood_screen.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بلاغاتي'),
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // مثال على بلاغ
            Card(
              child: ListTile(
                leading: const Icon(Icons.report, color: Color(0xFF1E3A8A)),
                title: const Text('بلاغ سيول في شارع الزبيري'),
                subtitle: const Text('تم الإرسال: 2025-09-01\nالحالة: قيد المعالجة'),
                onTap: () {
                  // تفاصيل البلاغ
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.report, color: Color(0xFF1E3A8A)),
                title: const Text('بلاغ تجمع مياه في حي الأصبحي'),
                subtitle: const Text('تم الإرسال: 2025-08-28\nالحالة: تم الحل'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            // يمكن إضافة المزيد من البلاغات هنا
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // إضافة بلاغ جديد
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportFloodScreen(),
                          ),
                        );
                },
                icon: const Icon(Icons.add, color: Color(0xFF1E3A8A)),
                label: const Text('إضافة بلاغ جديد', style: TextStyle(color: Color(0xFF1E3A8A))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
