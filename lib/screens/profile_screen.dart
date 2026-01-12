import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/controllers/profile_controller.dart';
import 'package:google/core/widgets/custom_app_bar.dart';
import 'package:google/core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'profile'.tr,
        onPressed: () => controller.goToNotifications,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Obx(
            () => Column(
              children: [
                // 1. User Info Header
                _buildUserInfoHeader(context, controller),
                const SizedBox(height: 20),

                // 2. Account Section
                _buildSectionHeader(context, 'account'.tr),
                _buildActionButton(
                  context,
                  icon: Icons.assignment_outlined,
                  title: 'reports'.tr,
                  subtitle: 'view_reports'.tr,
                  onTap: controller.goToMyReports,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'notifications'.tr,
                  subtitle: 'manage_notifications'.tr,
                  onTap: controller.goToNotifications,
                ),
                const SizedBox(height: 24),

                // 3. Settings Section
                _buildSectionHeader(context, 'settings'.tr),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('العربية'),
                            onTap: () => controller.changeLanguage('ar'),
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
                            onTap: () => controller.changeLanguage('en'),
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
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  icon:
                      controller.currentTheme.value == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
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
                            onTap:
                                () => controller.changeTheme(ThemeMode.system),
                            selected:
                                controller.currentTheme.value ==
                                ThemeMode.system,
                          ),
                          ListTile(
                            title: Text('light_mode'.tr),
                            leading: const Icon(Icons.light_mode),
                            onTap:
                                () => controller.changeTheme(ThemeMode.light),
                            selected:
                                controller.currentTheme.value ==
                                ThemeMode.light,
                          ),
                          ListTile(
                            title: Text('dark_mode'.tr),
                            leading: const Icon(Icons.dark_mode),
                            onTap: () => controller.changeTheme(ThemeMode.dark),
                            selected:
                                controller.currentTheme.value == ThemeMode.dark,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // 4. Support Section
                _buildSectionHeader(context, 'support'.tr),
                _buildActionButton(
                  context,
                  icon: Icons.health_and_safety_outlined,
                  title: 'safety_guide'.tr,
                  subtitle: 'safety_guide_desc'.tr,
                  onTap: controller.goToSafetyGuidelines,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  icon: Icons.quiz_outlined,
                  title: 'faq_title'.tr,
                  subtitle: 'faq_desc'.tr,
                  onTap: controller.goToFAQ,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  icon: Icons.contact_support_outlined,
                  title: 'contact_support'.tr,
                  subtitle: 'contact_support_desc'.tr,
                  onTap: controller.goToContact,
                ),
                const SizedBox(height: 32),

                // Logout Button
                TextButton.icon(
                  onPressed: controller.logout,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: Text(
                    'logout'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 4, left: 4),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textSecondary
                    : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoHeader(
    BuildContext context,
    ProfileController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 26, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(
                controller.nameController.text.isNotEmpty
                    ? controller.nameController.text
                    : 'أحمد محمد', // Fallback
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.cityController.text.isNotEmpty
                        ? controller.cityController.text
                        : 'صنعاء',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ],
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
            color: Colors.black.withOpacity(0.03), // Subtle shadow
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ), // Reduced padding
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondary
                            : Theme.of(context).primaryColor,
                    size: 22, // Smaller icon
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15, // Smaller font
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12, // Smaller font
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
