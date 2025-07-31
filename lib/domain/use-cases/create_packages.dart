import 'package:umraah_app/domain/entities/create_package_entity.dart';
import '../../core/network/api_response.dart';
import '../repositories/repositories.dart';

class CreatePackages {
  final UserRepository repository;

  CreatePackages(this.repository);

  Future<ApiResult?> call(CreatePackageEntity createPackageEntity,) {
    return repository.createPackage(createPackageEntity);
  }

}
