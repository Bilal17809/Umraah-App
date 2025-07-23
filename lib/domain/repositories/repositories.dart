
import '../entities/user_entities.dart';
abstract class UserRepository {
  Future<String?> register(UserEntity user);
}
