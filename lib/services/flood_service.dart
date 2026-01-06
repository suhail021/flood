import 'package:dio/dio.dart';
import 'package:google/core/utils/backend_endpoint.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/models/risk_area_model.dart';
import 'package:google/models/critical_alert_model.dart';
import 'package:google/models/updates_model.dart';
import 'package:google/models/report_model.dart';
import 'dart:io' as java_io;

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

  Future<CriticalAlertResponse> getCriticalAlerts() async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final String? token = await userPrefs.getToken();

      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.criticalAlerts}',
        options: Options(
          headers:
              token != null
                  ? ApiConstants.headersWithToken(token)
                  : ApiConstants.headers,
        ),
      );

      if (response.statusCode == 200) {
        return CriticalAlertResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load critical alerts');
      }
    } catch (e) {
      throw Exception('Error fetching critical alerts: $e');
    }
  }

  Future<bool> addAlarm({
    required double lat,
    required double lng,
    String? desc,
    required java_io.File image,
  }) async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final String? token = await userPrefs.getToken();

      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap({
        'latitude': lat,
        'longitude': lng,
        'description': desc ?? '',
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.alarms}',
        data: formData,
        options: Options(
          headers:
              token != null
                  ? ApiConstants.headersWithToken(token)
                  : ApiConstants.headers,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to submit report');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response!.data['message'] ?? 'Failed to submit report',
        );
      }
      throw Exception('Network error occurred: $e');
    } catch (e) {
      throw Exception('Error submitting report: $e');
    }
  }

  Future<UpdatesResponse> checkForUpdates() async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final String? token = await userPrefs.getToken();

      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.updates}',
        options: Options(
          headers:
              token != null
                  ? ApiConstants.headersWithToken(token)
                  : ApiConstants.headers,
        ),
      );

      if (response.statusCode == 200) {
        return UpdatesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to check for updates');
      }
    } catch (e) {
      throw Exception('Error checking for updates: $e');
    }
  }

  Future<List<ReportModel>> getMyReports() async {
    try {
      final UserPreferences userPrefs = UserPreferences();
      final String? token = await userPrefs.getToken();

      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.myAlarms}',
        options: Options(
          headers:
              token != null
                  ? ApiConstants.headersWithToken(token)
                  : ApiConstants.headers,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<dynamic> list = [];

        if (data is Map && data.containsKey('alarms')) {
          list = data['alarms'];
        } else if (data is Map && data.containsKey('data')) {
          list = data['data'];
        } else if (data is List) {
          list = data;
        }

        return list.map((e) => ReportModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      throw Exception('Error fetching reports: $e');
    }
  }
}
