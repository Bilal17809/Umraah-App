import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/use-cases/reset_password.dart';

import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordCase resetPasswordCase;

  ResetPasswordCubit(this.resetPasswordCase) : super(ResetPasswordState());

  Future<void> resetPassword(String token, String newPassword) async {
    emit(state.copyWith(isLoading: true));

    final result = await resetPasswordCase.call(token, newPassword);

    if (result?.success == true) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        passwordReset: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result?.message ?? "Password reset failed.",
      ));
    }
  }
}
