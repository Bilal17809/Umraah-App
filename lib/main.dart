import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/use-cases/login_case.dart';
import '/domain/use-cases/otp_case.dart';
import '/domain/use-cases/profile_case.dart';
import '/domain/use-cases/signup_case.dart';
import '/presentation/login/bloc/login_cubit.dart';
import '/presentation/profile/bloc/profile_cubit.dart';
import '/presentation/signup/bloc/signup_cubit.dart';
import '/presentation/signup/view/signup_page.dart';
import '/presentation/verify_otp/bloc/verify_otp_cubit.dart';
import 'core/network/api_client.dart';
import 'data/data_source/network_data_sr.dart';
import 'data/repositories_impl/repositories_impl.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = AuthRemoteDataSource(apiClient);
  final userRepository = UserRepositoryImpl(remoteDataSource);
  final registerUseCase = SignupUseCase(userRepository);
  final otpUseCase = OtpVerifyUseCase(userRepository);
  final loginUseCase= LoginUseCase(userRepository);
  final profileCase= ProfileUseCase(userRepository);

  runApp(MyApp(
    registerUseCase: registerUseCase,
    otpUseCase: otpUseCase,
    loginUseCase: loginUseCase,
      profileCase: profileCase,
  ));
}

class MyApp extends StatelessWidget {
  final SignupUseCase registerUseCase;
  final OtpVerifyUseCase otpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileCase;

  const MyApp({
    super.key,
    required this.registerUseCase,
    required this.otpUseCase,
    required this.loginUseCase,
    required this.profileCase

  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignupCubit(registerUseCase),
        ),
        BlocProvider(
          create: (_) => OtpVerifyCubit(otpUseCase),
        ),
        BlocProvider(
          create: (_) => LoginCubit(loginUseCase),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(profileCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Umrah App',
        home: SignupView(),
      ),
    );
  }
}

