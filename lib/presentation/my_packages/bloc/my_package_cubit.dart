import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_packages_state.dart';
import '/data/model/create_package.dart';


class MyPackageCubit extends Cubit<MyPackagesState> {
  final MyPackagesUseCase _myPackages;

  MyPackageCubit(this._myPackages) : super(const MyPackagesState());

  Future<void> myPackages({required int status}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _myPackages.call(status: status);
    if (result.success && result.data != null) {
      final List<CreatePackageModel> packages = (result.data as List)
          .map((json) => CreatePackageModel.fromJson(json as Map<String, dynamic>))
          .toList();

      emit(state.copyWith(isLoading: false, isSuccess: true, data: packages));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: result.message ?? "Failed to load packages"));
    }
  }

// Future<void> myPackages({int status=0}) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
  //   final result = await _myPackages.call(status: status);
  //   if (result.success) {
  //     emit(state.copyWith(isLoading: false, isSuccess: true, data: result.data));
  //   } else {
  //     emit(state.copyWith(isLoading: false, errorMessage: result.message ?? "Failed to load packages"));
  //   }
  // }
}

