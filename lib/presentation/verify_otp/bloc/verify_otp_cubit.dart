import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/verify_otp/bloc/verify_otp_state.dart';
import '/domain/use-cases/otp_case.dart';
import '/domain/entities/user_entities.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  final OtpVerifyUseCase _otpVerifyUseCase;

  OtpVerifyCubit(this._otpVerifyUseCase) : super(const OtpVerifyState());

  Future<void> verifyOtp(OtpEntity user) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isOtpVerified: false,
      isOtpResent: false,
    ));

    final result = await _otpVerifyUseCase.call(user);

    if (result!.success) {
      emit(state.copyWith(
        isLoading: false,
        isOtpVerified: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.message ?? 'OTP verification failed',
      ));
    }
  }

  Future<void> resendOtp(OtpEntity user) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isOtpVerified: false,
      isOtpResent: false,
    ));

    final result = await _otpVerifyUseCase.resendCall(user);

    if (result!.success) {
      emit(state.copyWith(
        isLoading: false,
        isOtpResent: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.message ?? 'OTP resend failed',
      ));
    }
  }

}
