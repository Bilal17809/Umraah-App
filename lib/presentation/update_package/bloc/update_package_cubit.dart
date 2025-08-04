// lib/presentation/cubit/update_package_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/create_package_entity.dart';
import '../../../domain/use-cases/update_package.dart';
import 'update_package_state.dart';

class UpdatePackageCubit extends Cubit<UpdatePackageState> {
  final UpdatePackageCase updatePackage;

  UpdatePackageCubit(this.updatePackage) : super(const UpdatePackageState());

  Future<void> update(String id, CreatePackageEntity entity) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await updatePackage(id, entity);

    if (result != null && result.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: result?.message ?? 'Update failed'));
    }
  }
}
