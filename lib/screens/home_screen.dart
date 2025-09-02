import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google/screens/setting_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/flood_zone_model.dart';
import 'report_flood_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Polygon> _floodZones = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createFloodZones();
    _createMarkers();
  }

  void _createFloodZones() {
    // منطقة صنعاء - خطر منخفض
    _floodZones.add(
      Polygon(
        polygonId: const PolygonId('sanaa_low'),
        points: [
          const LatLng(15.3694, 44.1910),
          const LatLng(15.3694, 44.2010),
          const LatLng(15.3594, 44.2010),
          const LatLng(15.3594, 44.1910),
        ],
        fillColor: const Color.fromRGBO(76, 175, 80, 0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
      ),
    );

    // منطقة صنعاء - خطر متوسط
    _floodZones.add(
      Polygon(
        polygonId: const PolygonId('sanaa_medium'),
        points: [
          const LatLng(15.3794, 44.2010),
          const LatLng(15.3794, 44.2110),
          const LatLng(15.3694, 44.2110),
          const LatLng(15.3694, 44.2010),
        ],
        fillColor: const Color.fromRGBO(255, 235, 59, 0.3),
        strokeColor: Colors.yellow,
        strokeWidth: 2,
      ),
    );

    // منطقة صنعاء - خطر عالي
    _floodZones.add(
      Polygon(
        polygonId: const PolygonId('sanaa_high'),
        points: [
          const LatLng(15.3894, 44.2110),
          const LatLng(15.3894, 44.2210),
          const LatLng(15.3794, 44.2210),
          const LatLng(15.3794, 44.2110),
        ],
        fillColor: const Color.fromRGBO(255, 152, 0, 0.3),
        strokeColor: Colors.orange,
        strokeWidth: 2,
      ),
    );

    // منطقة صنعاء - خطر حرج
    _floodZones.add(
      Polygon(
        polygonId: const PolygonId('sanaa_critical'),
        points: [
          const LatLng(15.3994, 44.2210),
          const LatLng(15.3994, 44.2310),
          const LatLng(15.3894, 44.2310),
          const LatLng(15.3894, 44.2210),
        ],
        fillColor: const Color.fromRGBO(244, 67, 54, 0.3),
        strokeColor: Colors.red,
        strokeWidth: 2,
      ),
    );
  }

  void _createMarkers() {
    // علامة الموقع الحالي
    _markers.add(
      Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(15.3694, 44.1910),
        infoWindow: InfoWindow(title: 'موقعك الحالي', snippet: 'أنت هنا'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    // علامة منطقة الخطر
    _markers.add(
      Marker(
        markerId: MarkerId('danger_zone'),
        position: LatLng(15.3994, 44.2260),
        infoWindow: InfoWindow(
          title: 'منطقة خطر حرج',
          snippet: 'احتمال عالي لحدوث سيول',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // AppBar مخصص
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // أيقونة القائمة
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  // شعار التطبيق في الوسط
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.water_drop,
                            color: Color(0xFF1E3A8A),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'نظام التنبؤ الذكي للسيول',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // أيقونة الإشعارات
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
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
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(15.3694, 44.1910),
                zoom: 13.0,
              ),
              polygons: _floodZones,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          // بطاقات المناطق
          Container(
            height: 400,
            padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'مناطق محتملة للسيول',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A), // خلفية زرقاء
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ), // مسافة داخلية
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // حواف دائرية (اختياري)
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportFloodScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'تقديم بلاغ',
                        style: TextStyle(
                          color: Colors.white, // النص أبيض
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // قائمة البطاقات
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 10),
                    children: [
                      _buildRiskCard(
                        'منطقة صنعاء القديمة',
                        'منخفض',
                        Colors.green,
                        0.1,
                      ),
                      _buildRiskCard(
                        'منطقة صنعاء الجديدة',
                        'متوسط',
                        Colors.yellow,
                        0.3,
                      ),
                      _buildRiskCard(
                        'منطقة صنعاء الغربية',
                        'حرج',
                        Colors.red,
                        0.9,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(
    String name,
    String risk,
    Color color,
    double probability,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(_getRiskIcon(risk), color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'مستوى الخطر: $risk',
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'احتمالية: ${(probability * 100).toInt()}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: probability,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(probability * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getRiskIcon(String risk) {
    switch (risk) {
      case 'منخفض':
        return Icons.check_circle;
      case 'متوسط':
        return Icons.info;
      case 'عالي':
        return Icons.warning;
      case 'حرج':
        return Icons.dangerous;
      default:
        return Icons.help;
    }
  }
}
