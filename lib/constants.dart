
class AppUrls {
  static final AppUrls _instance = AppUrls._internal();
  late String _baseUrl;
  AppUrls._internal();

  factory AppUrls({
    String baseUrl = 'http://172.236.250.16:5000/api/v1',
  }) {
    _instance._baseUrl = baseUrl;
    return _instance;
  }
  String get baseUrl => _baseUrl;
  String get _auth => '$_baseUrl/register';
  String get getOTP => '$_auth/verify-phone';
  String get verifyOTP => '$_auth/verify-otp';
  String get registerUser => '$_auth/register';
  String get getUser => '$_auth/get-user';
  String get updateUser => '$_auth/update-user';
  String get uploadProfile => '$_auth/update-user/profile';
  String get ridesStatus => '$_baseUrl/rides/status';
  String get createPackage => '$_baseUrl/package/create';
  String get carList => '$_baseUrl/cars/list';
  String get rentAcar => '$_baseUrl/rent/rent';
  // AppUrls class
}
// class ApiResult {
//   final bool success;
//   final String message;
//   final dynamic data;
//
//   ApiResult({
//     required this.success,
//     required this.message,
//     this.data,
//   });
// }
