import '/core/common/cubit_state.dart';

class OtpVerifyState extends BaseState {
  const OtpVerifyState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });

  OtpVerifyState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return OtpVerifyState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
