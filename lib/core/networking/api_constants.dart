class ApiConstants {
  static const String baseUrl = 'https://flutter.tharadtech.com/api/';
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static String verify({
    required String email,
    required String code,
  }) =>
      'otp?email=$email&otp=$code';}
