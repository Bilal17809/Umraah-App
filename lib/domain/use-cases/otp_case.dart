import 'package:umraah_app/domain/entities/resend_otp_entity.dart';
import 'package:umraah_app/domain/entities/user_entities.dart';
import '/core/network/api_response.dart';
import '../repositories/repositories.dart';

class OtpVerifyUseCase {
  final UserRepository repository;

  OtpVerifyUseCase(this.repository);

  Future<ApiResult?> call(OtpEntity user) {
    return repository.otpVerify(user);
  }

  Future<ApiResult?> resendCall(ResendOtpEntity user) {
    return repository.resendVerificationOtp(user);
  }
}
