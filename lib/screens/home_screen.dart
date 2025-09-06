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
  final Set<Polyline> _floodZones = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createFloodZones();
    _createMarkers();
  }

  void _createFloodZones() {
    // منطقة صنعاء - خطر منخفض (Polyline أخضر)
    _floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_low'),
        points: const [
          LatLng(15.3694, 44.1910),
          LatLng(15.3694, 44.2010),
          LatLng(15.3594, 44.2010),
          LatLng(15.3594, 44.1910),
          LatLng(15.3694, 44.1910),
        ],
        color: Colors.green,
        width: 4,
      ),
    );

    // منطقة صنعاء - خطر متوسط (Polyline أصفر)
    _floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_medium'),
        points: const [
          LatLng(15.3794, 44.2010),
          LatLng(15.3794, 44.2110),
          LatLng(15.3694, 44.2110),
          LatLng(15.3694, 44.2010),
          LatLng(15.3794, 44.2010),
        ],
        color: Colors.yellow,
        width: 4,
      ),
    );
    // منطقة صنعاء - خطر حرج (Polyline أحمر)
    _floodZones.add(
      Polyline(
        polylineId: const PolylineId('sanaa_critical'),
        points: const [
LatLng(15.4503057, 44.2213646), LatLng(15.4492302, 44.2197553), LatLng(15.4486511, 44.2193476), LatLng(15.4479893, 44.2190901), LatLng(15.4472654, 44.2190257), LatLng(15.4453626, 44.2194120), LatLng(15.4433770, 44.2200557), LatLng(15.4415155, 44.2208926), LatLng(15.4403987, 44.2209569), LatLng(15.4392818, 44.2215148), LatLng(15.4366136, 44.2209569), LatLng(15.4352898, 44.2210428), LatLng(15.4340281, 44.2216007), LatLng(15.4327250, 44.2214934), LatLng(15.4321252, 44.2208496), LatLng(15.4325803, 44.2191760), LatLng(15.4330146, 44.2177383), LatLng(15.4327250, 44.2169658), LatLng(15.4319804, 44.2163435), LatLng(15.4305532, 44.2152492), LatLng(15.4281125, 44.2157856), LatLng(15.4159496, 44.2164508), LatLng(15.4127227, 44.2174808), LatLng(15.4101990, 44.2192403), LatLng(15.4090612, 44.2200128), LatLng(15.4082544, 44.2205278), LatLng(15.4055031, 44.2199913), LatLng(15.4041792, 44.2197124), LatLng(15.4001866, 44.2197553), LatLng(15.3984695, 44.2203990), LatLng(15.3971662, 44.2209355), LatLng(15.3963180, 44.2211501), LatLng(15.3955940, 44.2211286), LatLng(15.3951388, 44.2209999), LatLng(15.3902772, 44.2195193), LatLng(15.3873808, 44.2186824), LatLng(15.3853326, 44.2173520), LatLng(15.3843189, 44.2169229), LatLng(15.3828707, 44.2156998), LatLng(15.3817534, 44.2141763), LatLng(15.3810500, 44.2131463), LatLng(15.3798854, 44.2127708), LatLng(15.3787207, 44.2126741), LatLng(15.3778000, 44.2125561), LatLng(15.3774507, 44.2121386), LatLng(15.3772254, 44.2110989), LatLng(15.3766353, 44.2103926), LatLng(15.3760431, 44.2104409), LatLng(15.3754353, 44.2106608), LatLng(15.3742845, 44.2110873), LatLng(15.3732991, 44.2115245), LatLng(15.3728388, 44.2117713), LatLng(15.3724301, 44.2118893), LatLng(15.3718306, 44.2117817), LatLng(15.3710703, 44.2113954), LatLng(15.3707961, 44.2110306), LatLng(15.3706927, 44.2103816), LatLng(15.3706927, 44.2096627), LatLng(15.3706099, 44.2091263), LatLng(15.3704133, 44.2088581), LatLng(15.3698547, 44.2084128), LatLng(15.3686598, 44.2080158), LatLng(15.3682253, 44.2079086), LatLng(15.3676305, 44.2078925), LatLng(15.3670408, 44.2080212), LatLng(15.3667201, 44.2082277), LatLng(15.3665442, 44.2085201), LatLng(15.3660735, 44.2096895), LatLng(15.3657114, 44.2101133), LatLng(15.3650493, 44.2102689), LatLng(15.3596542, 44.2101992), LatLng(15.3593554, 44.2102592), LatLng(15.3588175, 44.2103236), LatLng(15.3582071, 44.2100876), LatLng(15.3576898, 44.2097872), LatLng(15.3566345, 44.2096477), LatLng(15.3552792, 44.2093580), LatLng(15.3541618, 44.2093365), LatLng(15.3535514, 44.2094438), LatLng(15.3532721, 44.2095726), LatLng(15.3529824, 44.2097335), LatLng(15.3527134, 44.2100446), LatLng(15.3523720, 44.2104523), LatLng(15.3521030, 44.2106455), LatLng(15.3513477, 44.2106991), LatLng(15.3502097, 44.2104094), LatLng(15.3488595, 44.2105543), LatLng(15.3477576, 44.2104899), LatLng(15.3472843, 44.2109781), LatLng(15.3469662, 44.2130702), LatLng(15.3466299, 44.2135047), LatLng(15.3460971, 44.2137461), LatLng(15.3452849, 44.2142664), LatLng(15.3450521, 44.2152535), LatLng(15.3447262, 44.2158489), LatLng(15.3436191, 44.2160099), LatLng(15.3395788, 44.2157417), LatLng(15.3387614, 44.2155754), LatLng(15.3374267, 44.2154734), LatLng(15.3364075, 44.2151194), LatLng(15.3359264, 44.2149960), LatLng(15.3351245, 44.2149906), LatLng(15.3334535, 44.2149316), LatLng(15.3325999, 44.2145347), LatLng(15.3316635, 44.2144381), LatLng(15.3298941, 44.2141109), LatLng(15.3288284, 44.2142986), LatLng(15.3280886, 44.2148351), LatLng(15.3276954, 44.2156236), LatLng(15.3272711, 44.2168521), LatLng(15.3269633, 44.2172464), LatLng(15.3265830, 44.2175119), LatLng(15.3258122, 44.2179464), LatLng(15.3252741, 44.2182039), LatLng(15.3242756, 44.2182522), LatLng(15.3236703, 44.2183112), LatLng(15.3217715, 44.2187135), LatLng(15.3205298, 44.2190622), LatLng(15.3195364, 44.2191266),
        ],
        color: Colors.red,
        width: 4,
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings,
                        color: Colors.white, size: 28),
                  ),
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
                          child: const Icon(Icons.water_drop,
                              color: Color(0xFF1E3A8A), size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'نظام التنبؤ الذكي للسيول',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications,
                        color: Colors.white, size: 28),
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
              polylines: _floodZones,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          // بطاقات المناطق
          Container(
            height: 400,
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
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
                        backgroundColor: const Color(0xFF1E3A8A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
                          color: Colors.white,
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
      String name, String risk, Color color, double probability) {
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
