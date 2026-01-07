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

  Future<Map<String, dynamic>> sendOtp({
    required String phoneNumber,
    String type = 'register',
  }) async {
    try {
      final Map<String, dynamic> data = {
        'phone_number': phoneNumber,
        'type': type,
      };

      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.sendOtp}',
        data: data,
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to send OTP');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? 'Failed to send OTP');
      } else {
        throw Exception('Network error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> resendOtp({
    required String phoneNumber,
    String type = 'register',
  }) async {
    try {
      final Map<String, dynamic> data = {
        'phone_number': phoneNumber,
        'type': type,
      };

      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.resendOtp}',
        data: data,
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to resend OTP');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? 'Failed to resend OTP');
      } else {
        throw Exception('Network error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
    String phoneNumber,
    String otp, {
    String? firstName,
    String? lastName,
    String? password,
    String type = 'register',
  }) async {
    try {
      final Map<String, dynamic> data = {
        'phone_number': phoneNumber,
        'otp': otp,
        'type': type,
      };

      if (firstName != null) data['first_name'] = firstName;
      if (lastName != null) data['last_name'] = lastName;
      if (password != null) data['password'] = password;

      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.verifyOtp}',
        data: data,
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Verification failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? 'Verification failed');
      } else {
        throw Exception('Network error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
