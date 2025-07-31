import 'package:umraah_app/data/model/login_model.dart';
import 'package:umraah_app/data/model/registration_model.dart';
import 'package:umraah_app/data/model/verifyopt_model.dart';
import '/core/local_data_storage/local_storage.dart';
import '/core/network/api_response.dart';
import '/domain/entities/user_entities.dart';
import '/domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';

// class UserRepositoryImpl implements UserRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   UserRepositoryImpl(this.remoteDataSource);
//
//   @override
//   Future<ApiResult> register(UserEntity user) async {
//     final model = UserModel.fromEntity(user);
//     return await remoteDataSource.registerUser(model);
//   }
//
//   @override
//   Future<ApiResult> otpVerify(OtpEntity user) async {
//     final otpModel = OtpVerifyModel.fromEntity(user);
//     return await remoteDataSource.verifyOtp(otpModel);
//   }
//
//   @override
//   Future<ApiResult> login(LoginEntity login) async {
//     final loginModel = LoginModel.fromEntity(login);
//     final result = await remoteDataSource.loginUser(loginModel);
//     if (result.success && result.data != null) {
//       final token = result.data;
//       await SecureStorage.saveToken(token);
//     }
//     return result;
//   }
//
//
//   @override
//   Future<ApiResult> profile() async {
//     final token = await SecureStorage.getToken();
//     if (token == null) {
//       return ApiResult(success: false, message: "Token not found");
//     }
//     return await remoteDataSource.profile(token);
//   }
//
//   @override
//   Future<ApiResult> logout() async{
//     final token = await SecureStorage.getToken();
//     if(token == null){
//       return ApiResult(success: false, message:"Token not found");
//     }
//     return await remoteDataSource.logout(token);
//   }
// }

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    final result = await remoteDataSource.registerUser(model);

    if (result.success && result.data != null) {
      final response = UserModel.fromJson(result.data);
      await _saveUserData(response, isRegister: true);
    }

    return result;
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
      SecureStorage.setLoggedInStatus(true);
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
  Future<ApiResult> logout() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    return await remoteDataSource.logout(token);
  }

  @override
  Future<ApiResult> deleteAccount() async{
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    return await remoteDataSource.deleteAccount(token);
  }

  /// ✅ Save user data to SecureStorage
  Future<void> _saveUserData(UserModel response, {bool isRegister = false}) async {
    await Future.wait([
      if (isRegister) SecureStorage.saveToken(response.token),
      SecureStorage.setLoggedInStatus(true),
      SecureStorage.saveEmial(response.email),
      SecureStorage.saveName('${response.firstName} ${response.lastName}'),
      SecureStorage.saveuserProfilePhoto(response.userImageBase64),
      SecureStorage.savePhone(response.phoneNumber),
      SecureStorage.saveVerificationStatus(response.isVerified),
    ]);
  }

}

