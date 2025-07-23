

import '../entities/user_entities.dart';
import '../repositories/repositories.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<String?> call(UserEntity user) {
    return repository.register(user);
  }
}
