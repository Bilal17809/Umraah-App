import '../../core/network/api_response.dart';
import '../entities/create_package_entity.dart';
import '../repositories/repositories.dart';

class UpdatePackageCase {
  final UserRepository repository;

  UpdatePackageCase(this.repository);

  Future<ApiResult?> call(String id, CreatePackageEntity createPackageEntity) {
    return repository.updatePackage(id, createPackageEntity);
  }
}
