import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class DeletePackage {
  final UserRepository repository;

  DeletePackage(this.repository);

  Future<ApiResult> call(String id) {
    return repository.deletePackage(id);
  }
}
