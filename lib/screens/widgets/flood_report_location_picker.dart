import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google/controllers/report_flood_controller.dart';
import 'package:google/screens/widgets/map_picker_screen.dart';

class FloodReportLocationPicker extends StatefulWidget {
  final ReportFloodController controller;

  const FloodReportLocationPicker({super.key, required this.controller});

  @override
  State<FloodReportLocationPicker> createState() =>
      _FloodReportLocationPickerState();
}

class _FloodReportLocationPickerState extends State<FloodReportLocationPicker> {
  GoogleMapController? _mapController;
  Worker? _locationWorker;

  @override
  void initState() {
    super.initState();
    // Listen to location changes and update map camera
    _locationWorker = ever(widget.controller.selectedLocation, (
      LatLng? location,
    ) {
      if (location != null && _mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(location));
      }
    });
  }

  @override
  void dispose() {
    _locationWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          widget.controller.isLocationLoading.value
                              ? null
                              : widget.controller.getCurrentLocation,
                      icon:
                          widget.controller.isLocationLoading.value
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Icon(Icons.my_location),
                      label: Text(
                        widget.controller.isLocationLoading.value
                            ? 'locating'.tr
                            : 'locate_me'.tr,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Get.to(
                          () => MapPickerScreen(
                            initialLocation:
                                widget.controller.selectedLocation.value,
                          ),
                        );
                        if (result != null && result is LatLng) {
                          widget.controller.selectedLocation.value = result;
                        }
                      },
                      icon: const Icon(Icons.map),
                      label: Text('pick_on_map'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6), // Blue
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (widget.controller.selectedLocation.value != null) ...[
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2C3E50), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: widget.controller.selectedLocation.value!,
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                      ),
                      Center(
                        child: Icon(
                          Icons.location_on,
                          size: 48,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${'coordinates'.tr}: ${widget.controller.selectedLocation.value!.latitude.toStringAsFixed(6)}, ${widget.controller.selectedLocation.value!.longitude.toStringAsFixed(6)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
