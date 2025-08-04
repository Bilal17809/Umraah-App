import '/core/network/api_response.dart';
import '../repositories/repositories.dart';

class MyPackagesUseCase {
  final UserRepository repository;

  MyPackagesUseCase(this.repository);

  Future<ApiResult> call({required int status}) {
    return repository.myPackages(status: status);
  }
}

