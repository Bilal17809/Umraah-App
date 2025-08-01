import '/core/common/cubit_state.dart';

// class OtpVerifyState extends BaseState {
//   const OtpVerifyState({
//     super.isLoading,
//     super.errorMessage,
//     super.isSuccess,
//   });
//
//   OtpVerifyState copyWith({
//     bool? isLoading,
//     String? errorMessage,
//     bool? isSuccess,
//   }) {
//     return OtpVerifyState(
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isSuccess: isSuccess ?? this.isSuccess,
//     );
//   }
// }
class OtpVerifyState {
  final bool isLoading;
  final String? errorMessage;
  final bool isOtpVerified;
  final bool isOtpResent;

  const OtpVerifyState({
    this.isLoading = false,
    this.errorMessage,
    this.isOtpVerified = false,
    this.isOtpResent = false,
  });

  OtpVerifyState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isOtpVerified,
    bool? isOtpResent,
  }) {
    return OtpVerifyState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      isOtpResent: isOtpResent ?? this.isOtpResent,
    );
  }
}
