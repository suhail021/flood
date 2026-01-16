import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:google/models/report_model.dart';
import 'dart:async';

class ReportDetailsScreen extends StatelessWidget {
  final ReportModel report;

  const ReportDetailsScreen({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText = report.statusName ?? report.status;

    if (report.statusColor != null && report.statusColor!.isNotEmpty) {
      try {
        statusColor = Color(
          int.parse(report.statusColor!.replaceFirst('#', '0xFF')),
        );
      } catch (_) {
        statusColor = Colors.grey;
      }
    } else {
      switch (report.status.toLowerCase()) {
        case 'pending':
          statusColor = Colors.orange;
          break;
        case 'processing':
          statusColor = Colors.blue;
          break;
        case 'solved':
          statusColor = Colors.green;
          break;
        default:
          statusColor = Colors.grey;
      }
    }

    final Set<Marker> markers = {
      Marker(
        markerId: MarkerId(report.id.toString()),
        position: LatLng(report.latitude, report.longitude),
        infoWindow: InfoWindow(title: 'report_location'.tr),
      ),
    };

    final Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(right: 24, left: 24),
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back_ios, size: 22),
        ),
        title: Text('report_details'.tr), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map Section
            SizedBox(
              height: 250,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(report.latitude, report.longitude),
                  zoom: 15,
                ),
                markers: markers,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status and Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: statusColor.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        report.addedAt,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description Title
                  Text(
                    'description'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),

                  // Description Body
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      report.description.isNotEmpty
                          ? report.description
                          : 'no_description'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Image if exists
                  if (report.image.isNotEmpty) ...[
                    Text(
                      'attached_image'.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        report.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
