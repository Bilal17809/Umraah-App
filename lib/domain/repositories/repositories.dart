import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/domain/entities/create_package_entity.dart';
import 'package:umraah_app/domain/entities/resend_otp_entity.dart';

import '../entities/update_user_profile.dart';
import '/core/network/api_response.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<ApiResult<dynamic>> register(UserEntity user);
  Future<ApiResult<dynamic>> otpVerify(OtpEntity user);
  Future<ApiResult<dynamic>> resendVerificationOtp(ResendOtpEntity user);
  Future<ApiResult<dynamic>> login(LoginEntity login);
  Future<ApiResult<dynamic>> profile();
  Future<ApiResult<dynamic>> updateProfile(UpdateUserProfileEntity user);
  Future<ApiResult<dynamic>> logout();
  Future<ApiResult<dynamic>> deleteAccount();
  Future<ApiResult> myPackages({required int status});
  Future<ApiResult<dynamic>> createPackage(CreatePackageEntity createPackage);
  Future<ApiResult> forgotPassword(String email);
  Future<ApiResult?> resetPassword(String token, String newPassword);
  Future<ApiResult> getPackages();
  Future<ApiResult> updatePackage(String id, CreatePackageEntity entity);

  Future<ApiResult> deletePackage(String id);

}
