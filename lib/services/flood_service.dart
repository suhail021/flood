import 'package:dio/dio.dart';
import 'package:google/core/utils/backend_endpoint.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/models/risk_area_model.dart';

class FloodService {
  final Dio _dio = Dio();

  Future<RiskAreaResponse> getRiskAreas() async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final String? token = await userPrefs.getToken();

      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.riskAreas}',
        options: Options(
          headers:
              token != null
                  ? ApiConstants.headersWithToken(token)
                  : ApiConstants.headers,
        ),
      );

      if (response.statusCode == 200) {
        return RiskAreaResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load risk areas');
      }
    } catch (e) {
      throw Exception('Error fetching risk areas: $e');
    }
  }
}
