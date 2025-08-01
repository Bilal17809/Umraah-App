import 'package:umraah_app/data/model/create_package.dart';
import 'package:umraah_app/domain/entities/create_package_entity.dart';

import '/core/network/api_response.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<ApiResult<dynamic>> register(UserEntity user);
  Future<ApiResult<dynamic>> otpVerify(OtpEntity user);
  Future<ApiResult<dynamic>> resendOtp(OtpEntity user);
  Future<ApiResult<dynamic>> login(LoginEntity login);
  Future<ApiResult<dynamic>> profile();
  Future<ApiResult<dynamic>> logout();
  Future<ApiResult<dynamic>> deleteAccount();

  Future<ApiResult<dynamic>> myPackages({int status});
  Future<ApiResult<dynamic>> createPackage(CreatePackageEntity createPackage);
}
