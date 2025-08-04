import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/forgot_password/bloc/forgot_password_state.dart';
import '/domain/use-cases/forgot_password_case.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit(this.forgotPasswordUseCase) : super(ForgotPasswordState());

  Future<void> sendResetLink(String email) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await forgotPasswordUseCase(email);
    if (result != null && result.success) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        emailSent: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result?.message ?? "Something went wrong",
      ));
    }
  }
}
