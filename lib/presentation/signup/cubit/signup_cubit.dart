import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/signup/cubit/signup_state.dart';
import '../../../domain/entities/user_entities.dart';
import '../../../domain/usecases/users_case.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase _useCase;

  RegisterCubit(this._useCase) : super(RegisterInitial());

  Future<void> register(UserEntity user) async {
    emit(RegisterLoading());
    final result = await _useCase(user);
    if (result == null) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterFailure(result));
    }
  }
}
