import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google/controllers/main_controller.dart';
import 'package:get/get.dart';
import 'package:google/screens/notifications_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google/screens/report_flood_screen.dart';
import 'package:google/services/flood_service.dart';
import 'package:google/models/risk_area_model.dart';
import 'package:google/core/utils/custom_toast.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/core/utils/marker_generator.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/controllers/auth_controller.dart';
import 'package:google/screens/phone_login_screen.dart';

class HomeController extends GetxController {
  final Completer<GoogleMapController> mapControllerCompleter = Completer();
  late GoogleMapController googleMapController;

  final RxSet<Polyline> floodZones = <Polyline>{}.obs;
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Circle> circles = <Circle>{}.obs;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final Set<int> _playedAlertIds = {};
  bool _isFirstFetch = true;

  final FloodService _floodService = FloodService();
  final RxList<ManualAlert> criticalAlerts = <ManualAlert>[].obs;
  final RxList<AiPrediction> aiPredictions = <AiPrediction>[].obs;

  final RxString searchQuery = ''.obs;

  List<ManualAlert> get filteredCriticalAlerts {
    if (searchQuery.isEmpty) return criticalAlerts;
    return criticalAlerts
        .where(
          (alert) =>
              alert.locationName.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              alert.alertTypeName.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ),
        )
        .toList();
  }

  List<AiPrediction> get filteredAiPredictions {
    if (searchQuery.isEmpty) return aiPredictions;
    return aiPredictions
        .where(
          (pred) => pred.locationName.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ),
        )
        .toList();
  }

  List<dynamic> get allRisks {
    final List<dynamic> all = [];
    all.addAll(filteredCriticalAlerts);
    all.addAll(filteredAiPredictions);
    all.sort((a, b) {
      final DateTime dateA = (a as dynamic).createdAt;
      final DateTime dateB = (b as dynamic).createdAt;
      int cmp = dateB.compareTo(dateA);
      if (cmp != 0) return cmp;
      return (b as dynamic).id.compareTo((a as dynamic).id); // Tie-breaker
    });
    return all;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  final RxBool isLoading = false.obs;
  Timer? _pollingTimer;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    // _createFloodZones();
    _getCurrentLocation();
    fetchRiskAreas();
    _startPolling();
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    searchFocusNode.dispose();
    super.onClose();
  }

  void unfocusSearch() {
    if (searchFocusNode.hasFocus) {
      searchFocusNode.unfocus();
    }
  }

  Future<void> fetchRiskAreas() async {
    try {
      if (criticalAlerts.isEmpty && aiPredictions.isEmpty) {
        isLoading.value = true;
      }
      final response = await _floodService.getRiskAreas();

      final newCritical = response.data.criticalAlerts.fromEmployees;
      final newAi = response.data.aiPredictions;

      // Comparison logic to prevent unnecessary updates
      bool criticalChanged = false;
      if (criticalAlerts.length != newCritical.length) {
        criticalChanged = true;
      } else {
        for (int i = 0; i < criticalAlerts.length; i++) {
          if (criticalAlerts[i] != newCritical[i]) {
            criticalChanged = true;
            break;
          }
        }
      }

      bool aiChanged = false;
      if (aiPredictions.length != newAi.length) {
        aiChanged = true;
      } else {
        for (int i = 0; i < aiPredictions.length; i++) {
          if (aiPredictions[i] != newAi[i]) {
            aiChanged = true;
            break;
          }
        }
      }

      if (criticalChanged) criticalAlerts.assignAll(newCritical);
      if (aiChanged) aiPredictions.assignAll(newAi);

      if (criticalChanged || aiChanged) {
        _updateMapObjects();
        _checkAndPlayAlertSound();
      }
      _isFirstFetch = false;
    } catch (e) {
      String errorMessage;
      bool isNetworkError = false;

      if (e is Failure) {
        errorMessage = e.errMessage;
        // Check if it's a network/connection error
        if (errorMessage.toLowerCase().contains('internet') ||
            errorMessage.toLowerCase().contains('connection')) {
          isNetworkError = true;
        }
      } else {
        errorMessage = 'Failed to update risk areas';
      }

      if (isNetworkError) {
        // Show network error dialog with retry option
        CustomToast.showActionDialog(
          message: 'check_internet_and_retry'.tr,
          primaryButtonText: 'retry'.tr,
          onPrimaryPressed: () {
            fetchRiskAreas(); // Retry fetching data
          },
          secondaryButtonText: 'cancel'.tr,
          onSecondaryPressed: () {
            // User cancelled, do nothing
          },
        );
      } else {
        // Show regular error toast for non-network errors
        // CustomToast.showError(errorMessage);
      }
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

  Future<void> _updateMapObjects() async {
    markers.clear();
    circles.clear();

    // Add markers and circles for critical alerts
    for (var alert in criticalAlerts) {
      final latLng = LatLng(alert.latitude, alert.longitude);
      final color = _getRiskColor(alert.riskLevel);

      final icon = await MarkerGenerator.createCustomMarkerBitmap(color);

      markers.add(
        Marker(
          markerId: MarkerId('manual_${alert.id}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: alert.locationName,
            snippet: '${alert.alertTypeName} - Risk: ${alert.riskLevel}%',
          ),
          icon: icon,
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
      final color = _getRiskColor(pred.riskLevel);

      final icon = await MarkerGenerator.createCustomMarkerBitmap(color);

      markers.add(
        Marker(
          markerId: MarkerId('ai_${pred.id}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: pred.locationName,
            snippet: '${pred.riskLevelName} - Risk: ${pred.riskLevel}%',
          ),
          icon: icon,
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

  Color _getRiskColor(int level) {
    if (level <= 40) {
      return Colors.green; // Normal
    } else if (level <= 70) {
      return const Color(0xffEAB308); // Cautious (Yellow/Amber) matches logic
    } else {
      return Colors.red; // Dangerous
    }
  }

  void _checkAndPlayAlertSound() {
    bool shouldPlay = false;
    for (var alert in criticalAlerts) {
      if (alert.riskLevel >= 70 && !_playedAlertIds.contains(alert.id)) {
        if (!_isFirstFetch) {
          shouldPlay = true;
        }
        _playedAlertIds.add(alert.id);
      }
    }

    // Also check AI predictions if they are considered "critical" enough
    for (var pred in aiPredictions) {
      if (pred.riskLevel >= 70 && !_playedAlertIds.contains(pred.id)) {
        if (!_isFirstFetch) {
          shouldPlay = true;
        }
        _playedAlertIds.add(pred.id);
      }
    }

    if (shouldPlay) {
      _playSound();
    }
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.stop(); // Stop potential previous sound
      await _audioPlayer.play(AssetSource('sounds/alert.mp3'));
    } catch (e) {
      debugPrint('Error playing alert sound: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.defaultDialog(
        title: 'location_disabled_title'.tr,
        middleText: 'location_disabled_message'.tr,
        textConfirm: 'open_settings'.tr,
        textCancel: 'cancel'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () async {
          Get.back();
          await Geolocator.openLocationSettings();
        },
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomToast.showError('تم رفض صلاحية الموقع');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CustomToast.showError('تم رفض صلاحية الموقع بشكل دائم');
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

  void goToProfile() {
    final MainController mainController = Get.find<MainController>();
    mainController.changeIndex(3); // Profile tab
  }

  void goToNotifications() {
    Get.to(() => const NotificationsScreen());
  }

  Future<void> goToReportFlood() async {
    final UserPreferences userPrefs = UserPreferences();
    final user = await userPrefs.getUser();

    if (user != null && user.role == 'guest') {
      Get.defaultDialog(
        title: 'guest_login_required_title'.tr,
        middleText: 'guest_login_required_message'.tr,
        textConfirm: 'login_now'.tr,
        textCancel: 'cancel'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close dialog
          if (Get.isRegistered<AuthController>()) {
            Get.find<AuthController>().logout();
          } else {
            // Fallback if controller is disposed
            final UserPreferences userPrefs = UserPreferences();
            userPrefs.clearSession();
            Get.offAll(() => const PhoneLoginScreen());
          }
        },
      );
    } else {
      Get.to(() => const ReportFloodScreen());
    }
  }

  void animateToLocation(LatLng location) async {
    final GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(location, 14.2));
  }

  // Logic from original file to create flood zones
  // void _createFloodZones() {
  //   // منطقة صنعاء - خطر منخفض (أخضر)
  //   floodZones.add(
  //     Polyline(
  //       polylineId: const PolylineId('sanaa_low'),
  //       points: const [
  //         LatLng(15.3582071, 44.2100876),
  //         LatLng(15.3576898, 44.2097872),
  //         LatLng(15.3566345, 44.2096477),
  //         LatLng(15.3552792, 44.2093580),
  //         LatLng(15.3541618, 44.2093365),
  //         LatLng(15.3535514, 44.2094438),
  //         LatLng(15.3532721, 44.2095726),
  //         LatLng(15.3529824, 44.2097335),
  //         LatLng(15.3527134, 44.2100446),
  //         LatLng(15.3523720, 44.2104523),
  //         LatLng(15.3521030, 44.2106455),
  //         LatLng(15.3513477, 44.2106991),
  //         LatLng(15.3502097, 44.2104094),
  //         LatLng(15.3488595, 44.2105543),
  //         LatLng(15.3477576, 44.2104899),
  //         LatLng(15.3472843, 44.2109781),
  //         LatLng(15.3469662, 44.2130702),
  //         LatLng(15.3466299, 44.2135047),
  //         LatLng(15.3460971, 44.2137461),
  //         LatLng(15.3452849, 44.2142664),
  //         LatLng(15.3450521, 44.2152535),
  //         LatLng(15.3447262, 44.2158489),
  //         LatLng(15.3436191, 44.2160099),
  //         LatLng(15.3395788, 44.2157417),
  //         LatLng(15.3387614, 44.2155754),
  //         LatLng(15.3374267, 44.2154734),
  //         LatLng(15.3364075, 44.2151194),
  //         LatLng(15.3359264, 44.2149960),
  //         LatLng(15.3351245, 44.2149906),
  //         LatLng(15.3334535, 44.2149316),
  //         LatLng(15.3325999, 44.2145347),
  //         LatLng(15.3316635, 44.2144381),
  //         LatLng(15.3298941, 44.2141109),
  //         LatLng(15.3288284, 44.2142986),
  //         LatLng(15.3280886, 44.2148351),
  //         LatLng(15.3276954, 44.2156236),
  //         LatLng(15.3272711, 44.2168521),
  //         LatLng(15.3269633, 44.2172464),
  //         LatLng(15.3265830, 44.2175119),
  //         LatLng(15.3258122, 44.2179464),
  //         LatLng(15.3252741, 44.2182039),
  //         LatLng(15.3242756, 44.2182522),
  //         LatLng(15.3236703, 44.2183112),
  //         LatLng(15.3217715, 44.2187135),
  //         LatLng(15.3205298, 44.2190622),
  //         LatLng(15.3195364, 44.2191266),
  //       ],
  //       color: Colors.green,
  //       width: 4,
  //     ),
  //   );

  //   // منطقة صنعاء - خطر متوسط (أصفر)
  //   floodZones.add(
  //     Polyline(
  //       polylineId: const PolylineId('sanaa_medium'),
  //       points: const [
  //         LatLng(15.4082544, 44.2205278),
  //         LatLng(15.4055031, 44.2199913),
  //         LatLng(15.4041792, 44.2197124),
  //         LatLng(15.4001866, 44.2197553),
  //         LatLng(15.3984695, 44.2203990),
  //         LatLng(15.3971662, 44.2209355),
  //         LatLng(15.3963180, 44.2211501),
  //         LatLng(15.3955940, 44.2211286),
  //         LatLng(15.3951388, 44.2209999),
  //         LatLng(15.3902772, 44.2195193),
  //         LatLng(15.3873808, 44.2186824),
  //         LatLng(15.3853326, 44.2173520),
  //         LatLng(15.3843189, 44.2169229),
  //         LatLng(15.3828707, 44.2156998),
  //         LatLng(15.3817534, 44.2141763),
  //         LatLng(15.3810500, 44.2131463),
  //         LatLng(15.3798854, 44.2127708),
  //         LatLng(15.3787207, 44.2126741),
  //         LatLng(15.3778000, 44.2125561),
  //         LatLng(15.3774507, 44.2121386),
  //         LatLng(15.3772254, 44.2110989),
  //         LatLng(15.3766353, 44.2103926),
  //         LatLng(15.3760431, 44.2104409),
  //         LatLng(15.3754353, 44.2106608),
  //         LatLng(15.3742845, 44.2110873),
  //         LatLng(15.3732991, 44.2115245),
  //         LatLng(15.3728388, 44.2117713),
  //         LatLng(15.3724301, 44.2118893),
  //         LatLng(15.3718306, 44.2117817),
  //         LatLng(15.3710703, 44.2113954),
  //         LatLng(15.3707961, 44.2110306),
  //         LatLng(15.3706927, 44.2103816),
  //         LatLng(15.3706927, 44.2096627),
  //         LatLng(15.3706099, 44.2091263),
  //         LatLng(15.3704133, 44.2088581),
  //         LatLng(15.3698547, 44.2084128),
  //         LatLng(15.3686598, 44.2080158),
  //         LatLng(15.3682253, 44.2079086),
  //         LatLng(15.3676305, 44.2078925),
  //         LatLng(15.3670408, 44.2080212),
  //         LatLng(15.3667201, 44.2082277),
  //         LatLng(15.3665442, 44.2085201),
  //         LatLng(15.3660735, 44.2096895),
  //         LatLng(15.3657114, 44.2101133),
  //         LatLng(15.3650493, 44.2102689),
  //         LatLng(15.3596542, 44.2101992),
  //         LatLng(15.3593554, 44.2102592),
  //         LatLng(15.3588175, 44.2103236),
  //       ],
  //       color: Colors.yellow,
  //       width: 4,
  //     ),
  //   );

  //   // منطقة صنعاء - خطر حرج (أحمر)
  //   floodZones.add(
  //     Polyline(
  //       polylineId: const PolylineId('sanaa_critical'),
  //       points: const [
  //         LatLng(15.4503057, 44.2213646),
  //         LatLng(15.4492302, 44.2197553),
  //         LatLng(15.4486511, 44.2193476),
  //         LatLng(15.4479893, 44.2190901),
  //         LatLng(15.4472654, 44.2190257),
  //         LatLng(15.4453626, 44.2194120),
  //         LatLng(15.4433770, 44.2200557),
  //         LatLng(15.4415155, 44.2208926),
  //         LatLng(15.4403987, 44.2209569),
  //         LatLng(15.4392818, 44.2215148),
  //         LatLng(15.4366136, 44.2209569),
  //         LatLng(15.4352898, 44.2210428),
  //         LatLng(15.4340281, 44.2216007),
  //         LatLng(15.4327250, 44.2214934),
  //         LatLng(15.4321252, 44.2208496),
  //         LatLng(15.4325803, 44.2191760),
  //         LatLng(15.4330146, 44.2177383),
  //         LatLng(15.4327250, 44.2169658),
  //         LatLng(15.4319804, 44.2163435),
  //         LatLng(15.4305532, 44.2152492),
  //         LatLng(15.4281125, 44.2157856),
  //         LatLng(15.4159496, 44.2164508),
  //         LatLng(15.4127227, 44.2174808),
  //         LatLng(15.4101990, 44.2192403),
  //         LatLng(15.4090612, 44.2200128),
  //       ],
  //       color: Colors.red,
  //       width: 4,
  //     ),
  //   );
  // }
}
