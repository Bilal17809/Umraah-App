import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/use-cases/create_packages.dart';
import '/domain/entities/create_package_entity.dart';
import 'create_package_state.dart';

class CreatePackageCubit extends Cubit<CreatePackageState> {
  final CreatePackages _createPackageUseCase;

  CreatePackageCubit(this._createPackageUseCase)
      : super(const CreatePackageState());

  Future<void> createPackage(CreatePackageEntity package) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await _createPackageUseCase(package);

    if (result != null && result.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result?.message ?? 'Package creation failed',
      ));
    }
  }
}
