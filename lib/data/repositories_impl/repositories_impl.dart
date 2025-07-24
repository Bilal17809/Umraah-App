import 'dart:convert';
import 'package:umraah_app/data/model/login_model.dart';

import '../model/registration_model.dart';
import '../model/verifyopt_model.dart';
import '/core/common/api_response.dart';
import '/domain/entities/user_entities.dart';
import '/domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);

@override
  Future<ApiResult> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    final response = await remoteDataSource.registerUser(model);
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("###########${response.body}");
        return ApiResult(success: true, message: body['message'] ?? 'Success');
      } else {
        return ApiResult(success: false, message: body['message'] ?? 'Error occurred');
      }
    } catch (_) {
      return ApiResult(success: false, message: "Invalid response from server");
    }
  }

  @override
  Future<ApiResult> otpVerify(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    final response = await remoteDataSource.verifyOtp(otpModel);
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("##### OTP Verify Response: ${response.body}");
        return ApiResult(success: true, message: body['message'] ?? 'OTP Verified');
      } else {
        return ApiResult(success: false, message: body['message'] ?? 'OTP verification failed');
      }
    } catch (e) {
      return ApiResult(success: false, message: "Invalid response from server");
    }
  }

  @override
  Future<ApiResult> login(LoginEntity login) async{
    final loginModel = LoginModel.fromEntity(login);
    final response = await remoteDataSource.loginUser(loginModel);
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("##### login Response: ${response.body}");
        return ApiResult(success: true, message: body['message'] ?? 'user login');
      } else {
        return ApiResult(success: false, message: body['message'] ?? 'login failed');
      }
    } catch (e) {
      return ApiResult(success: false, message: "Invalid response from server");
    }
  }

}
