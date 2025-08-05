import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/data/model/resend_otp.dart';
import 'package:umraah_app/data/model/update_profile_model.dart';

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

  // logout
  Future<ApiResult> deleteAccount(String token){
    return _client.delete(ApiRoutes.delete,token: token);
  }

  //create packages
  Future<ApiResult> createPackage(CreatePackageModel createPackageModel,String token){
    return _client.post(ApiRoutes.createPackage,createPackageModel.toJson(),token: token);
  }



  // get myPackages
  Future<ApiResult> myPackages(String token, {required int status}) {
    return _client.getMyPackage(
      ApiRoutes.myPackages,
      token: token,
      queryParams: {'status': status.toString()},
    );
  }

    // Verify OTP
  Future<ApiResult> resendOtp(ResendOtp otpModel) {
    return _client.post(ApiRoutes.resendOtp, otpModel.toJson());
  }
  // update profile
  Future<ApiResult> updateProfile(UpdateProfileModel user, String token) {
    return _client.post(ApiRoutes.updateProfile, user.toJson(), token: token);
  }
  // update profile
  Future<ApiResult> forgotPassword(String email) {
    return _client.post(ApiRoutes.forgetPassword, {
      'email': email,
    });
  }

  Future<ApiResult> resetPassword(String token, String newPassword) {
    return _client.post(ApiRoutes.resetPassword, {
        "token": token,
        "newPassword": newPassword,
      },
    );
  }

  Future<ApiResult> fetchPackages(String token) async {
    return await _client.get(ApiRoutes.packages, token: token);
  }

  // put update package
  Future<ApiResult> updatePackage(String id, CreatePackageModel package, String token) {
    return _client.put("${ApiRoutes.updatePackage}$id", package.toJson(), token: token);
  }

  Future<ApiResult> deletePackage(String id,String token) {
    return _client.deletePackage(ApiRoutes.deletePackage,token);
  }
}
