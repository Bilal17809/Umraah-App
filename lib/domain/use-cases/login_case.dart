import 'package:umraah_app/domain/entities/user_entities.dart';
import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<ApiResult?> call(LoginEntity login) {
    return repository.login(login);
  }
}