import 'package:bloc/bloc.dart';
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


}