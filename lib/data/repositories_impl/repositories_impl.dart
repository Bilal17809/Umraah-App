import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/data/model/login_model.dart';
import 'package:umraah_app/data/model/registration_model.dart';
import 'package:umraah_app/data/model/verifyopt_model.dart';
import 'package:umraah_app/domain/entities/create_package_entity.dart';
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
    final result = await remoteDataSource.registerUser(model);

    if (result.success && result.data != null) {
      final response = UserModel.fromJson(result.data);
      await _saveUserData(response, isRegister: true);
      return ApiResult(success: true, message: "Registration successful", data: response);
    }
    return ApiResult(success: false, message: result.message ?? "Registration failed");
  }

  // @override
  // Future<ApiResult> register(UserEntity user) async {
  //   final model = UserModel.fromEntity(user);
  //   final result = await remoteDataSource.registerUser(model);
  //   if (result.success && result.data != null) {
  //     final response = UserModel.fromJson(result.data);
  //     await _saveUserData(response, isRegister: true);
  //   }
  //   return result;
  // }

  @override
  Future<ApiResult> otpVerify(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    final result= await remoteDataSource.verifyOtp(otpModel);
    return ApiResult(success: true, message: "Otp send",data: result);;
  }

  @override
  Future<ApiResult> resendOtp(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    final result= await remoteDataSource.verifyOtp(otpModel);
    return ApiResult(success: true, message: "Otp Resend",data: result);
  }

  @override
  Future<ApiResult> login(LoginEntity login) async {
    final loginModel = LoginModel.fromEntity(login);
    final result = await remoteDataSource.loginUser(loginModel);
    if (result.success && result.data != null) {
      final token = result.data;
      await SecureStorage.saveToken(token);
      SecureStorage.setLoggedInStatus(true);
      return ApiResult(success: true, message: "Login successful", data: token);
    } else {
      return ApiResult(success: false, message: result.message ?? "Invalid credentials");
    }
  }

  // @override
  // Future<ApiResult> login(LoginEntity login) async {
  //   final loginModel = LoginModel.fromEntity(login);
  //   final result = await remoteDataSource.loginUser(loginModel);
  //   if (result.success && result.data != null) {
  //     final token = result.data;
  //     await SecureStorage.saveToken(token);
  //     SecureStorage.setLoggedInStatus(true);
  // }
  //   return result;
  // }

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

