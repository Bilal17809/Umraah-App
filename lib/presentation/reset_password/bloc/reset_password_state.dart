import '/core/common/cubit_state.dart';

class ResetPasswordState extends BaseState {
  final bool passwordReset;

  ResetPasswordState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    this.passwordReset = false,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? passwordReset,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      passwordReset: passwordReset ?? this.passwordReset,
    );
  }
}