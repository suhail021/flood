import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google/screens/notifications_screen.dart';
import 'package:google/screens/profile_screen.dart';
import 'package:google/screens/my_reports_screen.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'package:google/screens/security_help_screen.dart';

// Assuming HelpPage is defined in security_help_screen.dart or similar based on original import
// Original: import 'security_help_screen.dart'; then Navigator.push(HelpPage())
// Check file content later if needed, but for now I'll assume HelpPage is available or I'll fix import.
// Actually original had `import 'security_help_screen.dart';` and `Navigator.push(..., HelpPage())`.
// So HelpPage is likely in `security_help_screen.dart`.

class SettingController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController cityController;

  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  final List<String> cities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'إب',
    'ذمار',
    'البيضاء',
    'حضرموت',
    'شبوة',
    'مأرب',
    'الجوف',
    'صعدة',
    'عمران',
    'ريمة',
    'أبين',
    'لحج',
    'أب',
    'المحويت',
    'الضالع',
    'بيحان',
  ];

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    loadUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.onClose();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('user_name') ?? 'أحمد محمد';
    addressController.text =
        prefs.getString('user_address') ?? 'شارع الجمهورية، صنعاء';
    cityController.text = prefs.getString('user_city') ?? 'صنعاء';
  }

  Future<void> saveChanges(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Simulate save
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', nameController.text);
      await prefs.setString('user_address', addressController.text);
      await prefs.setString('user_city', cityController.text);

      isLoading.value = false;
      isEditing.value = false;

      Get.snackbar(
        'نجاح',
        'تم حفظ التغييرات بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void cancelEdit() {
    isEditing.value = false;
    loadUserData();
  }

  void logout() {
    Get.defaultDialog(
      title: 'تسجيل الخروج',
      middleText: 'هل أنت متأكد من تسجيل الخروج؟',
      textConfirm: 'تأكيد',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAll(() => const PhoneLoginScreen());
      },
    );
  }

  void goToProfile() {
    Get.to(() => const ProfileScreen());
  }

  void goToMyReports() {
    Get.to(() => const MyReportsScreen());
  }

  void goToNotifications() {
    Get.to(() => const NotificationsScreen());
  }

  void goToHelp() {
    Get.to(() => const SecurityHelpScreen());
  }
}
