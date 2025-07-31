
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_packages_state.dart';


class MyPackageCubit extends Cubit<MyPackagesState> {
  final MyPackages _myPackages;

  MyPackageCubit(this._myPackages) : super(const MyPackagesState());

  Future<void> myPackages({int status = 2}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _myPackages.call(status: status);
    if (result != null && result.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true, data: result.data));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: result?.message ?? "Failed to load packages"));
    }
  }
}

