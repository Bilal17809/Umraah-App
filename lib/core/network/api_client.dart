import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../config/enviroment_config.dart';
import 'api_response.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String baseUrl;

  ApiClient() : baseUrl = EnvironmentConfig.baseUrl;

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

      print('################### 🔁 Response body: ${response.body}');
      final json = jsonDecode(response.body);

      return ApiResult(
        success: response.statusCode == 200 || response.statusCode == 201,
        message: json['message'] ?? 'No message',
        data: json['data'] ?? json['packages'], // ✅ FIX HERE
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }


  // Future<ApiResult> get(String endpoint, {String? token}) async {
  //   try {
  //     final url = Uri.parse('$baseUrl$endpoint');
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         if (token != null) 'Authorization': 'Bearer $token',
  //       },
  //     );
  //     print('################### 🔁 Response body: ${response.body}');
  //     final json = jsonDecode(response.body);
  //     return ApiResult(
  //       success: response.statusCode == 200 || response.statusCode == 201,
  //       message: json['message'] ?? 'No message',
  //       data: json['data'],
  //     );
  //   } catch (e) {
  //     return ApiResult(success: false, message: 'Error: ${e.toString()}');
  //   }
  // }

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
        data: json['packages'],
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }

  // put package updated
  Future<ApiResult> put(String endpoint, Map<String, dynamic> body, {String? token}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final jsonBody = jsonEncode(body);
      print('📤 PUT URL: $url');
      print('📤 Headers: $headers');
      print('📤 Body: $jsonBody');

      final response = await http.put(url, headers: headers, body: jsonBody);

      print('🔁 Status Code: ${response.statusCode}');
      print('🔁 Response Body: ${response.body}');

      if (response.body.isEmpty) {
        return ApiResult(success: false, message: 'Empty response from server.');
      }

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


  Future<ApiResult> deletePackage(String endpoint,String id, String token,) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('################## 🔁 DELETE Status Code: ${response.statusCode}');
      print('🔁 DELETE Response Body: ${response.body}');
      print("####################### id of the package: $id");

      final json = jsonDecode(response.body);

      return ApiResult(
        success: response.statusCode == 200,
        message: json['message'] ?? 'Unknown',
      );
    } catch (e) {
      return ApiResult(success: false, message: 'Error: ${e.toString()}');
    }
  }


  // for images........
  // Future<ApiResult> postMultipart(String endpoint, Map<String, String> fields, File? image, {String? token})
  // async {
  //   try {
  //     final url = Uri.parse('$baseUrl$endpoint');
  //     final request = http.MultipartRequest('POST', url);
  //
  //     // Add token if exists
  //     if (token != null) {
  //       request.headers['Authorization'] = 'Bearer $token';
  //     }
  //
  //     // Add fields
  //     request.fields.addAll(fields);
  //
  //     // Add image file if exists
  //     if (image != null) {
  //       final bytes = await image.readAsBytes();
  //
  //       print("####################📦 Image byte length: ${bytes.length}");
  //
  //       final imageStream = http.MultipartFile.fromBytes(
  //         'packageImage',
  //         bytes,
  //         filename: image.path.split("/").last,
  //         contentType: MediaType('image', 'jpeg'),
  //       );
  //       request.files.add(imageStream);
  //     }
  //
  //
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     print('#############🔁 Status Code: ${response.statusCode}');
  //     print('################ 🔁 Body: ${response.body}');
  //
  //     Map<String, dynamic>? json;
  //     try {
  //       json = jsonDecode(response.body); // This will throw if body is empty or invalid
  //     } catch (e) {
  //       print("####################### JSON decode error: $e");
  //     }
  //
  //
  //     return ApiResult(
  //       success: response.statusCode == 200 || response.statusCode == 201,
  //       message: json?['message'] ?? 'Unknown',
  //       data: json?['data'],
  //     );
  //
  //   } catch (e) {
  //     return ApiResult(success: false, message: 'Error: ${e.toString()}');
  //   }
  // }


}
