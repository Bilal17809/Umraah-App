import 'package:umraah_app/domain/entities/user_entities.dart';
import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class OtpVerifyUseCase {
  final UserRepository repository;

  OtpVerifyUseCase(this.repository);

  Future<ApiResult?> call(OtpEntity user) {
    return repository.otpVerify(user);
  }
}
