import 'dart:io';

import 'package:http/http.dart' as _client;
import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/data/model/login_model.dart';
import 'package:umraah_app/data/model/registration_model.dart';
import 'package:umraah_app/data/model/verifyopt_model.dart';
import 'package:umraah_app/domain/entities/create_package_entity.dart';
import 'package:umraah_app/presentation/create_packages/view/create_packages_view.dart';
import '../../core/config/api_routes.dart';
import '../../core/network/api_client.dart';
import '/core/local_data_storage/local_storage.dart';
import '/core/network/api_response.dart';
import '/domain/entities/user_entities.dart';
import '/domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    return await remoteDataSource.registerUser(model);
  }

  @override
  Future<ApiResult> otpVerify(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    return await remoteDataSource.verifyOtp(otpModel);
  }

  @override
  Future<ApiResult> login(LoginEntity login) async {
    final loginModel = LoginModel.fromEntity(login);
    final result = await remoteDataSource.loginUser(loginModel);
    if (result.success && result.data != null) {
      final token = result.data;
      await SecureStorage.saveToken(token);
    }
    return result;
  }


  @override
  Future<ApiResult> profile() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    return await remoteDataSource.profile(token);
  }

  @override
  Future<ApiResult> logout() async{
    final token = await SecureStorage.getToken();
    if(token == null){
      return ApiResult(success: false, message:"Token not found");
    }
    return await remoteDataSource.logout(token);
  }



@override
  Future<ApiResult> createPackage(CreatePackageEntity createPackage) async{
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final createPackageModel = CreatePackageModel.fromEntity(createPackage);
    final result = await remoteDataSource.createPackage(createPackageModel,token);
    return result;
  }

  @override
  Future<ApiResult> myPackages({int status = 2}) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    return await remoteDataSource.myPackages(token, status: status);
  }

// @override
  // Future<ApiResult> myPackages() async{
  //   final token = await SecureStorage.getToken();
  //   if (token == null) {
  //     return ApiResult(success: false, message: "Token not found");
  //   }
  //   return await remoteDataSource.myPackages(token);
  // }
}

