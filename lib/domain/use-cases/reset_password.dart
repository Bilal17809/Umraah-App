import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class ResetPasswordCase {
  final UserRepository repository;

  ResetPasswordCase(this.repository);

  Future<ApiResult?> call(String token,String newPassword) {
    return repository.resetPassword(token, newPassword);
  }
}
