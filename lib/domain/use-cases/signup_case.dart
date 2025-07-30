import '../../core/network/api_response.dart';
import '../entities/user_entities.dart';
import '../repositories/repositories.dart';

class SignupUseCase {
  final UserRepository repository;
  SignupUseCase(this.repository);
  Future<ApiResult?> call(UserEntity user) {
    return repository.register(user);
  }
}


