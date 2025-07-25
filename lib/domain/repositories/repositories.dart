import '/core/network/api_response.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<ApiResult<dynamic>> register(UserEntity user);
  Future<ApiResult<dynamic>> otpVerify(OtpEntity user);
  Future<ApiResult<dynamic>> login(LoginEntity login);
  Future<ApiResult<dynamic>> profile();
}
