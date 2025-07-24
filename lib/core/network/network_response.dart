import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final baseUrl = "https://appsolace.com/umrahApi/public/api/";
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) {
    final url = Uri.parse('$baseUrl/$endpoint');
    return http.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode(body));
  }
}
