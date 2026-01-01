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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // AppBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: controller.goToSettings,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'app_title'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.goToNotifications,
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),

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
