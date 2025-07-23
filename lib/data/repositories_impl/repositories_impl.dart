

import '../../core/network/network_response.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';
import '../model /registration_model.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    final response = await remoteDataSource.registerUser(model);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return null;
    } else {
      return response.body;
    }
  }
}
