import 'package:bloc/bloc.dart';
import '../../../core/local_data_storage/local_storage.dart';
import '/domain/use-cases/profile_case.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>{
  final ProfileUseCase _profileUseCase;

  ProfileCubit(this._profileUseCase) : super( ProfileState());

  Future<void> getProfile() async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _profileUseCase();
    if (result!.success) {
      emit(state.copyWith(
        isSuccess: true,
        isLoading: false,
        errorMessage: null,
        profileData: result.data,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result.message,
      ));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _profileUseCase.call2();
    if (result != null && result.success) {
      emit(state.copyWith(
        isSuccess: true,
        isLoading: false,
        errorMessage: null,
        profileData: null,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result?.message ?? "Logout failed",
      ));
    }
  }

  Future<void> delete() async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _profileUseCase.call3();
    if (result != null && result.success) {
      await SecureStorage.clearAll();
      emit(state.copyWith(
        isSuccess: true,
        isLoading: false,
        errorMessage: null,
        profileData: null,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result?.message ?? "Delete failed",
      ));
    }
  }

}