import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_state.dart';
import '/domain/entities/user_entities.dart';
import '/domain/use-cases/signup_case.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _useCase;

  SignupCubit(this._useCase) : super(const SignupState());

  Future<void> signUp(UserEntity user) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _useCase(user);
    if (result!.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true, errorMessage: null));
    } else {
      emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: result.message));
    }

  }

  void pickImage() {
    emit(state.copyWith(imagePicked: true));
  }
}
