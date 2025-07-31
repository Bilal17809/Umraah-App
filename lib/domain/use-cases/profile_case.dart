import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class ProfileUseCase {
  final UserRepository repository;

  ProfileUseCase(this.repository);

  Future<ApiResult?> call() {
    return repository.profile();
  }

  Future<ApiResult?> call2(){
    return repository.logout();
  }

  Future<ApiResult?> call3(){
    return repository.deleteAccount();
  }
}
