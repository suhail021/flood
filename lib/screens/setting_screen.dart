import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Obx(
            () => Column(
              children: [
                // صورة الملف الشخصي
                _buildActionButton(
                  icon: Icons.person,
                  title: 'الملف الشخصي',
                  subtitle: 'إدارة الملف الشخصي',
                  onTap: controller.goToProfile,
                ),
                const SizedBox(height: 16),
                // أزرار إضافية
                if (!controller.isEditing.value) ...[
                  _buildActionButton(
                    icon: Icons.assignment,
                    title: 'البلاغات',
                    subtitle: 'عرض جميع بلاغاتك',
                    onTap: controller.goToMyReports,
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    icon: Icons.notifications,
                    title: 'الإشعارات',
                    subtitle: 'إدارة الإشعارات',
                    onTap: controller.goToNotifications,
                  ),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    icon: Icons.help,
                    title: 'المساعدة والدعم',
                    subtitle: 'الدعم والمساعدة',
                    onTap: controller.goToHelp,
                  ),
                  const SizedBox(height: 24),

                  // زر تسجيل الخروج
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: const Color(0xFF2C3E50), size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF2C3E50),
          size: 20,
        ),
      ),
    );
  }
}
