import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  // Save Functions
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> saveId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', id);
  }

  static Future<void> saveEmial(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  static Future<void> saveuserProfilePhoto(String photoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('photo', photoUrl);
  }

  static Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  static Future<void> savePhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }

  static Future<void> saveVerificationStatus(bool isVerified) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('verification', isVerified);
  }

  static Future<void> setLoggedInStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged', isLoggedIn);
  }

  static Future<void> deleteLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged');
  }

  // Get Functions
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  static Future<String?> getEmial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  static Future<String?> getProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('photo');
  }

  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  static Future<bool> getVerificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('verification') ?? false;
  }

  static Future<bool> getLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged') ?? false;
  }

  // Clear all data
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
