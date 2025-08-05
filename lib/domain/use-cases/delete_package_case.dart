import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class DeletePackageCase {
  final UserRepository repository;

  DeletePackageCase(this.repository);

  Future<ApiResult> call(String id) {
    return repository.deletePackage(id);
  }
}
