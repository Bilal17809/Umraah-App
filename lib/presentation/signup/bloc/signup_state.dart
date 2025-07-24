import '/core/common/cubit_state.dart';
class SignupState extends BaseState {
  final bool imagePicked;

  const SignupState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    this.imagePicked = false,
  });

  SignupState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? imagePicked,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      imagePicked: imagePicked ?? this.imagePicked,
    );
  }
}

