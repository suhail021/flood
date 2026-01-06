import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google/services/flood_service.dart';

class ReportFloodController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final FloodService _floodService = FloodService();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final Rx<String?> selectedReportType = Rx<String?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLocationLoading = false.obs;
  // ... (keep existing properties)

  Future<void> getCurrentLocation() async {
    isLocationLoading.value = true;
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Location services are disabled.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Error', 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Error',
          'Location permissions are permanently denied, we cannot request permissions.',
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      selectedLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
    } finally {
      isLocationLoading.value = false;
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

      try {
        final success = await _floodService.addAlarm(
          lat: selectedLocation.value!.latitude,
          lng: selectedLocation.value!.longitude,
          desc: descriptionController.text,
          image: selectedImage.value!,
        );

        if (success) {
          Get.snackbar(
            'نجاح',
            'تم إرسال البلاغ بنجاح',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.back();
        }
      } catch (e) {
        Get.snackbar(
          'خطأ',
          e.toString().replaceAll('Exception: ', ''),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في اختيار الصورة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void setReportType(String? type) {
    selectedReportType.value = type;
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
