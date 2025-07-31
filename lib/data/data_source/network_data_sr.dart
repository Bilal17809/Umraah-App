import 'package:umraah_app/data/model/create_package.dart';

import '../../core/config/api_routes.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../model/login_model.dart';
import '../model/registration_model.dart';
import '../model/verifyopt_model.dart';

class AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSource(this._client);

  // Register user
  Future<ApiResult> registerUser(UserModel user) {
    return _client.post(ApiRoutes.register, user.toJson());
  }

  // Verify OTP
  Future<ApiResult> verifyOtp(OtpVerifyModel otpModel) {
    return _client.post(ApiRoutes.verifyOTP, otpModel.toJson());
  }

  // Login user
  Future<ApiResult> loginUser(LoginModel loginModel) {
    return _client.post(ApiRoutes.login, loginModel.toJson());
  }

  // Get profile
  Future<ApiResult> profile(String token) {
    return _client.get(ApiRoutes.profile, token: token);
  }

  // logout
  Future<ApiResult> logout(String token){
    return _client.get(ApiRoutes.logout,token: token);
  }

  // create packages
  Future<ApiResult> createPackage(CreatePackageModel createPackageModel,String token){
    return _client.post(ApiRoutes.createPackage,createPackageModel.toJson(),token: token);
  }

  // get myPackages
  Future<ApiResult> myPackages(String token, {int status = 2}) {
    return _client.getMyPackage(
      ApiRoutes.myPackages,
      token: token,
      queryParams: {'status': status.toString()},
    );
  }

  // Future<ApiResult> myPackages(String token){
  //   return _client.get(ApiRoutes.myPackages,token: token);
  // }
}
