import '/core/network/api_response.dart';
import '../repositories/repositories.dart';

class GetPackagesCase {
  final UserRepository repository;

  GetPackagesCase(this.repository);

  Future<ApiResult?> call() {
    return repository.getPackages();
  }
}
