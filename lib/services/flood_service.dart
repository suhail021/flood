import 'package:dio/dio.dart';
import 'package:google/core/utils/backend_endpoint.dart';
import 'package:google/core/utils/user_preferences.dart';
import 'package:google/models/risk_area_model.dart';
import 'package:google/models/critical_alert_model.dart';
import 'package:google/models/updates_model.dart';
import 'package:google/models/report_model.dart';
import 'package:google/core/errors/failures.dart';
import 'dart:io' as java_io;
import 'package:http_parser/http_parser.dart';

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
        throw ServerFailure('Failed to load risk areas');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
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
        throw ServerFailure('Failed to load critical alerts');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
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

      String extension = fileName.split('.').last.toLowerCase();
      MediaType? contentType;

      if (extension == 'png') {
        contentType = MediaType('image', 'png');
      } else if (extension == 'jpg' || extension == 'jpeg') {
        contentType = MediaType('image', 'jpeg');
      } else {
        // Default fallbacks if needed, or let Dio handle it,
        // but explicit is better for "png/jpg" requirement.
        contentType = MediaType('image', 'jpeg');
      }

      FormData formData = FormData.fromMap({
        'latitude': lat,
        'longitude': lng,
        'description': desc ?? '',
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: contentType,
        ),
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
        throw ServerFailure(
          response.data['message'] ?? 'Failed to submit report',
        );
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
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
        throw ServerFailure('Failed to check for updates');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
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
        throw ServerFailure('Failed to load reports');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
