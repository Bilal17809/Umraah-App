import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/verify_otp/bloc/verify_otp_state.dart';
import '../../../domain/usecases/otp_case.dart';
import '/domain/entities/user_entities.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  final OtpVerifyUseCase _otpVerifyUseCase;

  OtpVerifyCubit(this._otpVerifyUseCase) : super(const OtpVerifyState());

  Future<void> verifyOtp(OtpEntity user) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _otpVerifyUseCase(user);
    if (result != null && result.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: result?.message ?? "Unknown error"));
    }
  }
}
