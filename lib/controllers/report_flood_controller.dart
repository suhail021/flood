import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportFloodController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLocationLoading = false.obs;
  final Rx<String?> selectedReportType = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> getCurrentLocation() async {
    isLocationLoading.value = true;

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            'خطأ',
            'تم رفض صلاحية الموقع',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLocationLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'خطأ',
          'صلاحيات الموقع مرفوضة بشكل دائم',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLocationLoading.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      selectedLocation.value = LatLng(position.latitude, position.longitude);
      isLocationLoading.value = false;

      Get.snackbar(
        'نجاح',
        'تم تحديد موقعك بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      isLocationLoading.value = false;
      Get.snackbar(
        'خطأ',
        'حدث خطأ في تحديد الموقع',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void submitReport() async {
    if (formKey.currentState!.validate()) {
      if (selectedImage.value == null) {
        Get.snackbar(
          'خطأ',
          'الرجاء اختيار صورة',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (selectedLocation.value == null) {
        Get.snackbar(
          'خطأ',
          'الرجاء تحديد الموقع',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      // Simulate report submission
      await Future.delayed(const Duration(seconds: 3));

      isLoading.value = false;

      Get.snackbar(
        'نجاح',
        'تم إرسال البلاغ بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back();
    }
  }

  void setReportType(String? type) {
    selectedReportType.value = type;
  }
}
