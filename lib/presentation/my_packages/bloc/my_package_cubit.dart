import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/use-cases/delete_package_case.dart';

import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_packages_state.dart';
import '/data/model/create_package.dart';


class MyPackageCubit extends Cubit<MyPackagesState> {
  final MyPackagesUseCase _myPackages;
  final DeletePackageCase _packageCase;

  MyPackageCubit(this._myPackages,this._packageCase) : super(const MyPackagesState());

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

  Future<void> deletePackage({required String id}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      final result = await _packageCase.call(id);
      if (result.success) {
        emit(state.copyWith(isLoading: false, isSuccess: true,));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: result.message ?? "Failed to delete package"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
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

