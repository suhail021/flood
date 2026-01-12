import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google/services/flood_service.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/controllers/my_reports_controller.dart';

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
        CustomToast.showError('location_service_disabled'.tr);
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          CustomToast.showError('location_permission_denied'.tr);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        CustomToast.showError('location_permission_permanently_denied'.tr);
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      selectedLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      CustomToast.showError('location_fetch_error'.tr);
    } finally {
      isLocationLoading.value = false;
    }
  }

  void submitReport() async {
    if (formKey.currentState!.validate()) {
      if (selectedImage.value == null) {
        CustomToast.showError('please_select_image'.tr);
        return;
      }

      if (selectedLocation.value == null) {
        CustomToast.showError('please_select_location'.tr);
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
          FocusManager.instance.primaryFocus?.unfocus();
          Get.back(); // Close the screen first
          // Small delay to ensure route transition allows dialog to show on top of previous screen
          await Future.delayed(const Duration(milliseconds: 100));
          CustomToast.showSuccess('report_sent_success'.tr);

          // Refresh reports list if controller is active
          if (Get.isRegistered<MyReportsController>()) {
            Get.find<MyReportsController>().fetchMyReports();
          }
        }
      } catch (e) {
        if (e is Failure) {
          CustomToast.showError(e.errMessage);
        } else {
          CustomToast.showError(e.toString().replaceAll('Exception: ', ''));
        }
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
      CustomToast.showError('image_pick_error'.tr);
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
