import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/entities/user_entities.dart';
import '/domain/use-cases/login_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState());

  Future<void> login(LoginEntity loginData) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _loginUseCase(loginData);
    if (result != null && result.success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: result?.message ?? "Login failed"));
    }
  }
}
