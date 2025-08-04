import 'package:umraah_app/domain/entities/update_user_profile.dart';

import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class UpdateProfileCase {
  final UserRepository repository;
  UpdateProfileCase(this.repository);
  Future<ApiResult?> call(UpdateUserProfileEntity user) {
    return repository.updateProfile(user);
  }
}


