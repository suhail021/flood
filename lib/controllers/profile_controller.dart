import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController
  phoneController; // Renamed from passController to be deeper
  late TextEditingController addressController;
  late TextEditingController cityController;

  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;
  final RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    loadUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.onClose();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('user_name') ?? 'أحمد محمد';
    userName.value = nameController.text; // Update observable
    addressController.text =
        prefs.getString('user_address') ?? 'شارع الجمهورية، صنعاء';
    cityController.text = prefs.getString('user_city') ?? 'صنعاء';
    // Assuming phone is stored or just dummy
    phoneController.text = prefs.getString('user_phone') ?? '770000000';
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      loadUserData(); // Revert changes if cancelled or just to be safe
    }
  }

  Future<void> saveChanges() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Simulate save
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', nameController.text);
      userName.value = nameController.text; // Update observable
      await prefs.setString('user_address', addressController.text);
      await prefs.setString('user_city', cityController.text);
      await prefs.setString('user_phone', phoneController.text);

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
}
