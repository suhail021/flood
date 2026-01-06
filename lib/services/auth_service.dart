import 'package:dio/dio.dart';
import 'package:google/core/utils/backend_endpoint.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.login}',
        data: {'phone_number': phone, 'password': password},
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? 'Login failed');
      } else {
        throw Exception('Network error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
