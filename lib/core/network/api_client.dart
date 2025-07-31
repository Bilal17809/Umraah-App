import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/enviroment_config.dart';
import 'api_response.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String baseUrl;

  ApiClient() : baseUrl = EnvironmentConfig.baseUrl;

  // Future<ApiResult> post(String endpoint, Map<String, dynamic> body, {String? token}) async {
  //   try {
  //     final url = Uri.parse('$baseUrl$endpoint');
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         if (token != null) 'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(body),
  //     );
  //     print('################### 🔁 Response body: ${response.body}');
  //     final json = jsonDecode(response.body);
  //     return ApiResult(
  //       success:response.statusCode == 200 || response.statusCode == 201,
  //       message: json['message'] ?? 'No message',
  //       data: json['token'],
  //     );
  //   } catch (e) {
  //     return ApiResult(success: false, message: 'Error: ${e.toString()}');
  //   }
  // }
  Future<ApiResult> post(String endpoint, Map<String, dynamic> body, {String? token}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print('################### 🔁 Response body: ${response.body}');
      final json = jsonDecode(response.body);
      final dynamic responseData = json.containsKey('token') ? json['token'] : json['data'];
      return ApiResult(
        success: response.statusCode == 200 || response.statusCode == 201,
        message: json['message'] ?? 'No message',
        data: responseData,
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }

  Future<ApiResult> get(String endpoint, {String? token}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      return ApiResult(
        success: response.statusCode == 200 || response.statusCode == 201,
        message: json['message'] ?? 'No message',
        data: json['data'],
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }

  Future<ApiResult> delete(String endpoint, {String? token}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      print('########### 🔁 DELETE Response body: ${response.body}');
      // Check if response has a body
      final bool hasBody = response.body.isNotEmpty;

      final json = hasBody ? jsonDecode(response.body) : {};

      return ApiResult(
        success: response.statusCode == 200 || response.statusCode == 204,
        message: json['message'] ?? 'Account deleted successfully.',
        data: json['data'],
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }


  // for get myPackages
  Future<ApiResult> getMyPackage(String endpoint, {String? token, Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      String rawBody = response.body;

      // Remove 'AGENT' prefix if present
      if (rawBody.startsWith('AGENT')) {
        rawBody = rawBody.substring('AGENT'.length);
      }

      final json = jsonDecode(rawBody);

      return ApiResult(
        success: response.statusCode == 200 || response.statusCode == 201,
        message: json['message'] ?? 'No message',
        data: json['packages'], // or json['data'] based on API
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }


}
