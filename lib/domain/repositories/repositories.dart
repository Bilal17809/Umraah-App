import '../../core/common/api_response.dart';
import '../entities/user_entities.dart';
abstract class UserRepository {
  Future<ApiResult?> register(UserEntity user);
  Future<ApiResult> otpVerify(OtpEntity user);
  Future<ApiResult> login(LoginEntity login);
}
