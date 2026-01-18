import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google/core/utils/backend_endpoint.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Map<String, dynamic>> sendOtp({
    required String phoneNumber,
    required String type,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.sendOtp,
        options: Options(headers: ApiConstants.headers),
        data: {'phone_number': phoneNumber, 'type': type},
      );

      print('📤 Send OTP Request: $phoneNumber, Type: $type');
      print('📥 Send OTP Response: ${response.statusCode} - ${response.data}');

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'send_otp_failed'.tr);
      }
    } catch (e) {
      print('❌ Send OTP Error: $e');
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        } else if (e.type == DioExceptionType.cancel) {
          throw Exception('request_cancelled'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
    String phoneNumber,
    String otp, {
    String? firstName,
    String? lastName,
    String? password,
    required String type,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'phone_number': phoneNumber,
        'otp': otp,
        'type': type,
      };

      if (type == 'register') {
        if (firstName != null && firstName.isNotEmpty) {
          body['first_name'] = firstName;
        }
        if (lastName != null && lastName.isNotEmpty) {
          body['last_name'] = lastName;
        }
        if (password != null && password.isNotEmpty) {
          body['password'] = password;
        }
      }

      print('📤 Verify OTP Request: $body');

      final response = await _dio.post(
        ApiConstants.verifyOtp,
        options: Options(headers: ApiConstants.headers),
        data: body,
      );

      print('📥 Verify OTP Response: ${response.statusCode}');
      print('📥 Response Body: ${response.data}');

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true &&
            data['token'] != null &&
            data['user'] != null) {
          print('✅ Verification successful - Token: ${data['token']}');
          return data;
        } else {
          throw Exception(data['message'] ?? 'verify_otp_failed'.tr);
        }
      } else {
        throw Exception(data['message'] ?? 'verify_otp_failed'.tr);
      }
    } catch (e) {
      print('❌ Verify OTP Error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        } else if (e.type == DioExceptionType.cancel) {
          throw Exception('request_cancelled'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> resendOtp({
    required String phoneNumber,
    required String type,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.resendOtp,
        options: Options(headers: ApiConstants.headers),
        data: {'phone_number': phoneNumber, 'type': type},
      );

      print('📤 Resend OTP Request: $phoneNumber');
      print(
        '📥 Resend OTP Response: ${response.statusCode} - ${response.data}',
      );

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'resend_otp_failed'.tr);
      }
    } catch (e) {
      print('❌ Resend OTP Error: $e');
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        options: Options(headers: ApiConstants.headers),
        data: {'phone_number': phoneNumber, 'password': password},
      );

      print('📤 Login Request: $phoneNumber');
      print('📥 Login Response: ${response.statusCode} - ${response.data}');

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'login_failed'.tr);
      }
    } catch (e) {
      print('❌ Login Error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> forgotPasswordSendOtp(String phoneNumber) async {
    try {
      final response = await _dio.post(
        ApiConstants.forgotPasswordSendOtp,
        options: Options(headers: ApiConstants.headers),
        data: {'phone_number': phoneNumber},
      );

      print('📤 Forgot Pass Send OTP Request: $phoneNumber');
      print(
        '📥 Forgot Pass Send OTP Response: ${response.statusCode} - ${response.data}',
      );

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'send_otp_failed'.tr);
      }
    } catch (e) {
      print('❌ Forgot Pass Send OTP Error: $e');
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        }
      }
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> forgotPasswordVerifyOtp(
    String phoneNumber,
    String otp,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.forgotPasswordVerifyOtp,
        options: Options(headers: ApiConstants.headers),
        data: {'phone_number': phoneNumber, 'otp': otp},
      );

      print('📤 Forgot Pass Verify OTP Request: $phoneNumber, $otp');
      print(
        '📥 Forgot Pass Verify OTP Response: ${response.statusCode} - ${response.data}',
      );

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'verify_otp_failed'.tr);
      }
    } catch (e) {
      print('❌ Forgot Pass Verify OTP Error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }

  Future<Map<String, dynamic>> resetPassword(
    String token,
    String newPassword,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.forgotPasswordReset,
        options: Options(headers: ApiConstants.headersWithToken(token)),
        data: {
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        },
      );

      print('📤 Reset Password Request');
      print(
        '📥 Reset Password Response: ${response.statusCode} - ${response.data}',
      );

      final data =
          response.data is Map<String, dynamic>
              ? response.data
              : {'message': response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'server_error'.tr);
      }
    } catch (e) {
      print('❌ Reset Password Error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('connection_timeout'.tr);
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('no_internet_connection'.tr);
        }
      }
      throw Exception('server_error'.tr);
    }
  }
}
