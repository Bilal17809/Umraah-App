import 'package:umraah_app/domain/entities/user_entities.dart';
import '/core/network/api_response.dart';
import '../repositories/repositories.dart';

class MyPackages {
  final UserRepository repository;

  MyPackages(this.repository);

  Future<ApiResult?> call({int status = 2}) {
    return repository.myPackages(status: status);
  }
}
