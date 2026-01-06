import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google/screens/setting_screen.dart';
import 'package:google/screens/notifications_screen.dart';
import 'package:google/screens/report_flood_screen.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/models/risk_area_model.dart';

class HomeController extends GetxController {
  final Completer<GoogleMapController> mapControllerCompleter = Completer();
  late GoogleMapController googleMapController;

  final RxSet<Polyline> floodZones = <Polyline>{}.obs;
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Circle> circles = <Circle>{}.obs;

  final FloodService _floodService = FloodService();
  final RxList<ManualAlert> criticalAlerts = <ManualAlert>[].obs;
  final RxList<AiPrediction> aiPredictions = <AiPrediction>[].obs;

  final RxBool isLoading = false.obs;
  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();
    _createFloodZones();
    _getCurrentLocation();
    fetchRiskAreas();
    _startPolling();
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchRiskAreas() async {
    try {
      if (!isLoading.value) isLoading.value = true;
      final response = await _floodService.getRiskAreas();

      criticalAlerts.assignAll(response.data.criticalAlerts.fromEmployees);
      aiPredictions.assignAll(response.data.aiPredictions);

      _updateMapObjects();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update risk areas');
    } finally {
      isLoading.value = false;
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkForUpdates();
    });
  }

  Future<void> _checkForUpdates() async {
    try {
      final updatesResponse = await _floodService.checkForUpdates();
      if (updatesResponse.success && updatesResponse.hasUpdates) {
        bool needsRefresh = false;
        for (var update in updatesResponse.updates) {
          if ((update.type == 'critical_alert' && update.action == 'new') ||
              update.type == 'risk_area' ||
              update.type == 'critical_alert') {
            needsRefresh = true;
          }
        }

        if (needsRefresh) {
          await fetchRiskAreas();
        }
      }
    } catch (e) {
      // Silently fail on polling errors to avoid annoying the user
      debugPrint('Polling error: $e');
    }
  }

  void _updateMapObjects() {
    markers.clear();
    circles.clear();

    // Add markers and circles for critical alerts
    for (var alert in criticalAlerts) {
      final latLng = LatLng(alert.latitude, alert.longitude);
      final color = Colors.red;

      markers.add(
        Marker(
          markerId: MarkerId('manual_${alert.id}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: alert.locationName,
            snippet: '${alert.alertTypeName} - Risk: ${alert.riskLevel}%',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

      circles.add(
        Circle(
          circleId: CircleId('manual_circle_${alert.id}'),
          center: latLng,
          radius: 500, // 500 meters
          fillColor: color.withOpacity(0.3),
          strokeColor: color,
          strokeWidth: 2,
        ),
      );
    }

    // Add markers and circles for AI predictions
    for (var pred in aiPredictions) {
      final latLng = LatLng(pred.latitude, pred.longitude);
      final color = _parseColor(pred.riskColor);

      markers.add(
        Marker(
          markerId: MarkerId('ai_${pred.id}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: pred.locationName,
            snippet: '${pred.riskLevelName} - Risk: ${pred.riskLevel}%',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            pred.riskLevel > 50
                ? BitmapDescriptor.hueOrange
                : BitmapDescriptor.hueGreen,
          ),
        ),
      );

      circles.add(
        Circle(
          circleId: CircleId('ai_circle_${pred.id}'),
          center: latLng,
          radius: 500, // 500 meters
          fillColor: color.withOpacity(0.3),
          strokeColor: color,
          strokeWidth: 2,
        ),
      );
    }
  }

  Color _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return Colors.green;
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (_) {
      return Colors.green;
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'خطأ',
        'خدمة الموقع غير مفعلة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'خطأ',
          'تم رفض صلاحية الموقع',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'خطأ',
        'تم رفض صلاحية الموقع بشكل دائم',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14.1,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapControllerCompleter.isCompleted) {
      mapControllerCompleter.complete(controller);
      googleMapController = controller;
    }
  }

  void goToSettings() {
    Get.to(() => const SettingScreen());
  }

  void goToNotifications() {
    Get.to(() => const NotificationsScreen());
  }

  void goToReportFlood() {
    Get.to(() => const ReportFloodScreen());
  }

  void animateToLocation(LatLng location) async {
    final GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(location, 13.2));
  }

  // Logic from original file to create flood zones
  void _createFloodZones() {
    // منطقة صنعاء - خطر منخفض (أخضر)
    floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_low'),
        points: const [
          LatLng(15.3582071, 44.2100876),
          LatLng(15.3576898, 44.2097872),
          LatLng(15.3566345, 44.2096477),
          LatLng(15.3552792, 44.2093580),
          LatLng(15.3541618, 44.2093365),
          LatLng(15.3535514, 44.2094438),
          LatLng(15.3532721, 44.2095726),
          LatLng(15.3529824, 44.2097335),
          LatLng(15.3527134, 44.2100446),
          LatLng(15.3523720, 44.2104523),
          LatLng(15.3521030, 44.2106455),
          LatLng(15.3513477, 44.2106991),
          LatLng(15.3502097, 44.2104094),
          LatLng(15.3488595, 44.2105543),
          LatLng(15.3477576, 44.2104899),
          LatLng(15.3472843, 44.2109781),
          LatLng(15.3469662, 44.2130702),
          LatLng(15.3466299, 44.2135047),
          LatLng(15.3460971, 44.2137461),
          LatLng(15.3452849, 44.2142664),
          LatLng(15.3450521, 44.2152535),
          LatLng(15.3447262, 44.2158489),
          LatLng(15.3436191, 44.2160099),
          LatLng(15.3395788, 44.2157417),
          LatLng(15.3387614, 44.2155754),
          LatLng(15.3374267, 44.2154734),
          LatLng(15.3364075, 44.2151194),
          LatLng(15.3359264, 44.2149960),
          LatLng(15.3351245, 44.2149906),
          LatLng(15.3334535, 44.2149316),
          LatLng(15.3325999, 44.2145347),
          LatLng(15.3316635, 44.2144381),
          LatLng(15.3298941, 44.2141109),
          LatLng(15.3288284, 44.2142986),
          LatLng(15.3280886, 44.2148351),
          LatLng(15.3276954, 44.2156236),
          LatLng(15.3272711, 44.2168521),
          LatLng(15.3269633, 44.2172464),
          LatLng(15.3265830, 44.2175119),
          LatLng(15.3258122, 44.2179464),
          LatLng(15.3252741, 44.2182039),
          LatLng(15.3242756, 44.2182522),
          LatLng(15.3236703, 44.2183112),
          LatLng(15.3217715, 44.2187135),
          LatLng(15.3205298, 44.2190622),
          LatLng(15.3195364, 44.2191266),
        ],
        color: Colors.green,
        width: 4,
      ),
    );

    // منطقة صنعاء - خطر متوسط (أصفر)
    floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_medium'),
        points: const [
          LatLng(15.4082544, 44.2205278),
          LatLng(15.4055031, 44.2199913),
          LatLng(15.4041792, 44.2197124),
          LatLng(15.4001866, 44.2197553),
          LatLng(15.3984695, 44.2203990),
          LatLng(15.3971662, 44.2209355),
          LatLng(15.3963180, 44.2211501),
          LatLng(15.3955940, 44.2211286),
          LatLng(15.3951388, 44.2209999),
          LatLng(15.3902772, 44.2195193),
          LatLng(15.3873808, 44.2186824),
          LatLng(15.3853326, 44.2173520),
          LatLng(15.3843189, 44.2169229),
          LatLng(15.3828707, 44.2156998),
          LatLng(15.3817534, 44.2141763),
          LatLng(15.3810500, 44.2131463),
          LatLng(15.3798854, 44.2127708),
          LatLng(15.3787207, 44.2126741),
          LatLng(15.3778000, 44.2125561),
          LatLng(15.3774507, 44.2121386),
          LatLng(15.3772254, 44.2110989),
          LatLng(15.3766353, 44.2103926),
          LatLng(15.3760431, 44.2104409),
          LatLng(15.3754353, 44.2106608),
          LatLng(15.3742845, 44.2110873),
          LatLng(15.3732991, 44.2115245),
          LatLng(15.3728388, 44.2117713),
          LatLng(15.3724301, 44.2118893),
          LatLng(15.3718306, 44.2117817),
          LatLng(15.3710703, 44.2113954),
          LatLng(15.3707961, 44.2110306),
          LatLng(15.3706927, 44.2103816),
          LatLng(15.3706927, 44.2096627),
          LatLng(15.3706099, 44.2091263),
          LatLng(15.3704133, 44.2088581),
          LatLng(15.3698547, 44.2084128),
          LatLng(15.3686598, 44.2080158),
          LatLng(15.3682253, 44.2079086),
          LatLng(15.3676305, 44.2078925),
          LatLng(15.3670408, 44.2080212),
          LatLng(15.3667201, 44.2082277),
          LatLng(15.3665442, 44.2085201),
          LatLng(15.3660735, 44.2096895),
          LatLng(15.3657114, 44.2101133),
          LatLng(15.3650493, 44.2102689),
          LatLng(15.3596542, 44.2101992),
          LatLng(15.3593554, 44.2102592),
          LatLng(15.3588175, 44.2103236),
        ],
        color: Colors.yellow,
        width: 4,
      ),
    );

    // منطقة صنعاء - خطر حرج (أحمر)
    floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_critical'),
        points: const [
          LatLng(15.4503057, 44.2213646),
          LatLng(15.4492302, 44.2197553),
          LatLng(15.4486511, 44.2193476),
          LatLng(15.4479893, 44.2190901),
          LatLng(15.4472654, 44.2190257),
          LatLng(15.4453626, 44.2194120),
          LatLng(15.4433770, 44.2200557),
          LatLng(15.4415155, 44.2208926),
          LatLng(15.4403987, 44.2209569),
          LatLng(15.4392818, 44.2215148),
          LatLng(15.4366136, 44.2209569),
          LatLng(15.4352898, 44.2210428),
          LatLng(15.4340281, 44.2216007),
          LatLng(15.4327250, 44.2214934),
          LatLng(15.4321252, 44.2208496),
          LatLng(15.4325803, 44.2191760),
          LatLng(15.4330146, 44.2177383),
          LatLng(15.4327250, 44.2169658),
          LatLng(15.4319804, 44.2163435),
          LatLng(15.4305532, 44.2152492),
          LatLng(15.4281125, 44.2157856),
          LatLng(15.4159496, 44.2164508),
          LatLng(15.4127227, 44.2174808),
          LatLng(15.4101990, 44.2192403),
          LatLng(15.4090612, 44.2200128),
        ],
        color: Colors.red,
        width: 4,
      ),
    );
  }
}
