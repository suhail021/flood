class BackendEndpoint {
  static const addUserData = 'users';
  static const getUserData = 'users';
  static const isUserExists = 'users';
  static const getProducts = 'products';
  static const addorders = 'orders';
  static const signup =
      'https://mintcream-kudu-673423.hostingersite.com/api/auth/register';
}

// lib/core/utils/api_constants.dart
class ApiConstants {
  static const String baseUrl =
      'https://mintcream-kudu-673423.hostingersite.com/api';

  static const String riskAreas = '/flood/risk-areas';
  static const String criticalAlerts = '/flood/critical-alerts';
  static const String updates = '/flood/updates';
  static const String alarms = '/alarms';
  static const String myAlarms = '/alarms/my-alarms';

  // Auth Endpoints
  static const String sendOtp = '/auth/send-otp';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';

  // Forgot Password Endpoints
  static const String forgotPasswordSendOtp = '/auth/forgot-password/send-otp';
  static const String forgotPasswordVerifyOtp =
      '/auth/forgot-password/verify-otp';
  static const String forgotPasswordReset = '/auth/forgot-password/reset';

  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> headersWithToken(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
