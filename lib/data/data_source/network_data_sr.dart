import 'package:http/http.dart' as http;
import '../../core/network/network_response.dart';
import '../model /registration_model.dart';

class AuthRemoteDataSource {
  final ApiClient _client;
  AuthRemoteDataSource(this._client);
  Future<http.Response> registerUser(UserModel user) {
    return _client.post('register', user.toJson());
  }
}

