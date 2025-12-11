import 'package:flutter/material.dart';
import 'package:google/screens/report_flood_screen.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('البلاغات', style: TextStyle(color: Colors.white)),
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
                side: BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
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
                subtitle: const Text(
                  'تم الإرسال: 2025-09-01\nالحالة: قيد المعالجة',
                  style: TextStyle(color: Color(0xFF64748B)),
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
                side: BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.green),
                ),
                title: const Text(
                  'بلاغ تجمع مياه في حي الأصبحي',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                subtitle: const Text(
                  'تم الإرسال: 2025-08-28\nالحالة: تم الحل',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
            // يمكن إضافة المزيد من البلاغات هنا
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // إضافة بلاغ جديد
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportFloodScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('إضافة بلاغ جديد'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
