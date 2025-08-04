import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class ForgotPasswordUseCase {
  final UserRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<ApiResult?> call(String email) {
    return repository.forgotPassword(email);
  }
}
