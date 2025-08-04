import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/data/model/login_model.dart';
import 'package:umraah_app/data/model/registration_model.dart';
import 'package:umraah_app/data/model/update_profile_model.dart';
import 'package:umraah_app/data/model/verifyopt_model.dart';
import 'package:umraah_app/domain/entities/create_package_entity.dart';
import '/domain/entities/resend_otp_entity.dart';
import '../../domain/entities/update_user_profile.dart';
import '../model/resend_otp.dart';
import '/core/local_data_storage/local_storage.dart';
import '/core/network/api_response.dart';
import '/domain/entities/user_entities.dart';
import '/domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);

  // ✅ Register
  @override
  Future<ApiResult> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    final result = await remoteDataSource.registerUser(model);
    if (result.success) {
      if (result.data != null) {
        final response = UserModel.fromJson(result.data);
        await _saveUserData(response, isRegister: true);
        return ApiResult(success: true, message: result.message, data: response);
      }
      return ApiResult(success: true, message: result.message);
    }
    return ApiResult(success: false, message: result.message ?? "Registration failed");
  }

  // ✅ OTP Verify
  @override
  Future<ApiResult> otpVerify(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    final result = await remoteDataSource.verifyOtp(otpModel);
    if (result.success) {
      return ApiResult(success: true, message: result.message ?? "OTP verified", data: result.data);
    }
    return ApiResult(success: false, message: result.message ?? "OTP verification failed");
  }

  // ✅ Resend OTP
  @override
  Future<ApiResult> resendVerificationOtp(ResendOtpEntity user) async {
    final otpModel = ResendOtp.fromEntity(user);
    final result = await remoteDataSource.resendOtp(otpModel);

    if (result.success) {
      return ApiResult(success: true, message: result.message ?? "OTP resent", data: result.data);
    }
    return ApiResult(success: false, message: result.message ?? "Failed to resend OTP");
  }



  // ✅ Login
  @override
  Future<ApiResult> login(LoginEntity login) async {
    final loginModel = LoginModel.fromEntity(login);
    final result = await remoteDataSource.loginUser(loginModel);
    if (result.success) {
      final token = result.data;
      await SecureStorage.saveToken(token);
      SecureStorage.setLoggedInStatus(true);
      return ApiResult(success: true, message: result.message ?? "Login successful", data: token);
    }
    return ApiResult(success: false, message: result.message ?? "Invalid credentials");
  }


  // ✅ Profile
  @override
  Future<ApiResult> profile() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final result = await remoteDataSource.profile(token);
    return result;
  }

  // ✅ Logout
  @override
  Future<ApiResult> logout() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final result = await remoteDataSource.logout(token);
    return result;
  }

  // ✅ Delete Account
  @override
  Future<ApiResult> deleteAccount() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final result = await remoteDataSource.deleteAccount(token);
    return result;
  }

  // ✅ Save User Data to Storage
  Future<void> _saveUserData(UserModel response, {bool isRegister = false}) async {
    await Future.wait([
      if (isRegister) SecureStorage.saveToken(response.token),
      SecureStorage.setLoggedInStatus(true),
      SecureStorage.saveEmial(response.email),
      SecureStorage.savePassword(response.password),
      SecureStorage.saveType(response.userType),
      SecureStorage.saveName('${response.firstName} ${response.lastName}'),
      SecureStorage.saveuserProfilePhoto(response.userImageBase64),
      SecureStorage.savePhone(response.phoneNumber),
      SecureStorage.saveVerificationStatus(response.isVerified),
    ]);
  }

  @override
  Future<ApiResult> createPackage(CreatePackageEntity createPackage) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final createPackageModel = CreatePackageModel.fromEntity(createPackage);
    final result = await remoteDataSource.createPackage(createPackageModel, token);
    return  ApiResult(success: true, message: "create successfully",data: result);
  }

  @override
  Future<ApiResult> myPackages({int status = 2}) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final result = await remoteDataSource.myPackages(token, status: status);
    return result;
  }

  @override
  Future<ApiResult> updateProfile(UpdateUserProfileEntity user) async {
    final token = await SecureStorage.getToken();
    print("##########>>>>>>$token");
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    final model = UpdateProfileModel.fromEntity(user);
    final result = await remoteDataSource.updateProfile(model, token);
    if (result.success && result.data != null) {
      final response = UpdateProfileModel.fromJson(result.data);
      return ApiResult(success: true, message: result.message, data: response);
    }
    return ApiResult(success: false, message: result.message ?? "Profile update failed");
  }


  @override
  Future<ApiResult> forgotPassword(String email) async {
    return await remoteDataSource.forgotPassword(email);
  }

  @override
  Future<ApiResult?> resetPassword(String token, String newPassword) async{
    return await remoteDataSource.resetPassword(token, newPassword);
  }
}
