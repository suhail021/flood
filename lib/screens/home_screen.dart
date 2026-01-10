import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google/controllers/home_controller.dart';
import 'package:google/screens/widgets/home_risk_card.dart';
import 'package:google/screens/widgets/home_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'app_title'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.goToNotifications,
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // الخريطة
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(15.3694, 44.1910),
                      zoom: 13.0,
                    ),
                    polylines: controller.floodZones.toSet(),
                    markers: controller.markers.toSet(),
                    circles: controller.circles.toSet(),
                    onMapCreated: controller.onMapCreated,
                  ),
                ),

                // Search Bar - أضفنا هنا شريط البحث الشفاف
                const HomeSearchBar(),
              ],
            ),
          ),

          // البطاقات
          HomeRiskCard(controller: controller),
        ],
      ),
    );
  }
}
