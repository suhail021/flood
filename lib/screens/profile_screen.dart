import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('profile'.tr, style: const TextStyle(color: Colors.white)),
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
                  context,
                  icon: Icons.person,
                  title: 'profile'.tr,
                  subtitle: 'manage_profile'.tr,
                  onTap: controller.goToProfile,
                ),
                const SizedBox(height: 16),

                _buildActionButton(
                  context,
                  icon: Icons.language,
                  title: 'language'.tr,
                  subtitle:
                      Get.locale?.languageCode == 'ar' ? 'العربية' : 'English',
                  onTap: () {
                    Get.defaultDialog(
                      title: 'change_language'.tr,
                      content: Column(
                        children: [
                          ListTile(
                            title: const Text('العربية'),
                            onTap: () {
                              controller.changeLanguage('ar');
                              // Get.back();
                            },
                            trailing:
                                Get.locale?.languageCode == 'ar'
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                    : null,
                          ),
                          ListTile(
                            title: const Text('English'),
                            onTap: () {
                              controller.changeLanguage('en');
                              // Get.back();
                            },
                            trailing:
                                Get.locale?.languageCode == 'en'
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                    : null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // أزرار إضافية
                if (!controller.isEditing.value) ...[
                  _buildActionButton(
                    context,
                    icon: Icons.assignment,
                    title: 'reports'.tr,
                    subtitle: 'view_reports'.tr,
                    onTap: controller.goToMyReports,
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    context,
                    icon: Icons.notifications,
                    title: 'notifications'.tr,
                    subtitle: 'manage_notifications'.tr,
                    onTap: controller.goToNotifications,
                  ),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    context,
                    icon: Icons.help,
                    title: 'help_support'.tr,
                    subtitle: 'support_desc'.tr,
                    onTap: controller.goToHelp,
                  ),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    context,
                    icon: Icons.brightness_6,
                    title: 'theme'.tr,
                    subtitle: 'select_theme'.tr,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'select_theme'.tr,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('system_default'.tr),
                              leading: const Icon(Icons.brightness_auto),
                              onTap: () {
                                controller.changeTheme(ThemeMode.system);
                              },
                              selected:
                                  controller.currentTheme.value ==
                                  ThemeMode.system,
                            ),
                            ListTile(
                              title: Text('light_mode'.tr),
                              leading: const Icon(Icons.light_mode),
                              onTap: () {
                                controller.changeTheme(ThemeMode.light);
                              },
                              selected:
                                  controller.currentTheme.value ==
                                  ThemeMode.light,
                            ),
                            ListTile(
                              title: Text('dark_mode'.tr),
                              leading: const Icon(Icons.dark_mode),
                              onTap: () {
                                controller.changeTheme(ThemeMode.dark);
                              },
                              selected:
                                  controller.currentTheme.value ==
                                  ThemeMode.dark,
                            ),
                          ],
                        ),
                      );
                    },
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
                      child: Text(
                        'logout'.tr,
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

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).primaryColor.withOpacity(0.6)
                    : Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
