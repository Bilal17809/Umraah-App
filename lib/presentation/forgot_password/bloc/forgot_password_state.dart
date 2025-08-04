import '/core/common/cubit_state.dart';

class ForgotPasswordState extends BaseState {
  final bool emailSent;

  ForgotPasswordState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    this.emailSent = false,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? emailSent,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      emailSent: emailSent ?? this.emailSent,
    );
  }
}
