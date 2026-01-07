import 'package:flutter/material.dart';
import 'package:google/controllers/main_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'package:google/screens/security_help_screen.dart';
import 'package:google/screens/profile_screen.dart';

// Assuming HelpPage is defined in security_help_screen.dart or similar based on original import
// Original: import 'security_help_screen.dart'; then Navigator.push(HelpPage())
// Check file content later if needed, but for now I'll assume HelpPage is available or I'll fix import.
// Actually original had `import 'security_help_screen.dart';` and `Navigator.push(..., HelpPage())`.
// So HelpPage is likely in `security_help_screen.dart`.

class ProfileController extends GetxController {
  final RxString currentLang = 'ar'.obs;
  final Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

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
    loadLanguage();
    loadTheme();
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
        'success'.tr,
        'save_success'.tr,
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
      title: 'logout'.tr,
      middleText: 'logout_confirmation'.tr,
      textConfirm: 'confirm'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAll(() => const PhoneLoginScreen());
      },
    );
  }

  void goToProfile() {
    // Already on profile or handle specific profile details logic
    // For now, if it just opens ProfileScreen, it might be redundant if we are on the tab.
    // If we want to strictly follow existing logic, we leave it, but typically this button
    // inside the profile tab might mean "Edit Profile" or just be confusing.
    // Given the previous state was just pushing ProfileScreen (which is this screen),
    // let's leave it as is or better, maybe switch to editing mode?
    // But for now, I will update Reports and Notifications to switch tabs.
    Get.to(() => const ProfileScreen());
  }

  void goToMyReports() {
    final MainController mainController = Get.find<MainController>();
    mainController.changeIndex(1);
  }

  void goToNotifications() {
    final MainController mainController = Get.find<MainController>();
    mainController.changeIndex(2);
  }

  void goToHelp() {
    Get.to(() => const SecurityHelpScreen());
  }

  void changeLanguage(String langCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    Get.updateLocale(Locale(langCode));
    Get.back(); // Close the dialog
    Get.snackbar(
      'language_change_success_title'.tr,
      'language_change_success_body'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? langCode = prefs.getString('language_code');
    if (langCode != null) {
      currentLang.value = langCode;
      Get.updateLocale(Locale(langCode));
    }
  }

  void changeTheme(ThemeMode mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeString = 'system';
    if (mode == ThemeMode.light) themeString = 'light';
    if (mode == ThemeMode.dark) themeString = 'dark';

    await prefs.setString('theme_mode', themeString);
    Get.changeThemeMode(mode);
    currentTheme.value = mode;
    Get.back();
  }

  void loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themeString = prefs.getString('theme_mode');
    if (themeString == 'light') {
      currentTheme.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    } else if (themeString == 'dark') {
      currentTheme.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      currentTheme.value = ThemeMode.system;
      Get.changeThemeMode(ThemeMode.system);
    }
  }
}
