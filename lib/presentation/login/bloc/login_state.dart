import '/core/common/cubit_state.dart';

class LoginState extends BaseState {
  const LoginState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
