import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/use-cases/create_packages.dart';
import 'package:umraah_app/domain/use-cases/forgot_password_case.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/domain/use-cases/update_profile.dart';
import 'package:umraah_app/presentation/create_packages/bloc/create_package_cubit.dart';
import 'package:umraah_app/presentation/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_package_cubit.dart';
import 'package:umraah_app/presentation/update_profile/bloc/update_profile_cubit.dart';
import '/domain/use-cases/login_case.dart';
import '/domain/use-cases/otp_case.dart';
import '/domain/use-cases/profile_case.dart';
import '/domain/use-cases/signup_case.dart';
import '/presentation/login/bloc/login_cubit.dart';
import '/presentation/profile/bloc/profile_cubit.dart';
import '/presentation/signup/bloc/signup_cubit.dart';
import '/presentation/verify_otp/bloc/verify_otp_cubit.dart';
import 'core/network/api_client.dart';
import 'core/route/route.dart';
import 'core/route/route_name.dart';
import 'data/data_source/network_data_sr.dart';
import 'data/repositories_impl/repositories_impl.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  final remoteDataSource = AuthRemoteDataSource(apiClient);
  final userRepository = UserRepositoryImpl(remoteDataSource);
  final registerUseCase = SignupUseCase(userRepository);
  final otpUseCase = OtpVerifyUseCase(userRepository);
  final loginUseCase= LoginUseCase(userRepository);
  final profileCase= ProfileUseCase(userRepository);
  final updateProfileCase= UpdateProfileCase(userRepository);
  final createPackages = CreatePackages(userRepository);
  final myPackage = MyPackages(userRepository);
  final forgotPassword = ForgotPasswordUseCase(userRepository);

  runApp(MyApp(
    registerUseCase: registerUseCase,
    otpUseCase: otpUseCase,
    loginUseCase: loginUseCase,
    profileCase: profileCase,
    createPackages: createPackages,
    myPackages: myPackage,
    updateProfileCase: updateProfileCase,
    forgotPasswordUseCase: forgotPassword,
  ));
}

class MyApp extends StatelessWidget {
  final SignupUseCase registerUseCase;
  final OtpVerifyUseCase otpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileCase;
  final CreatePackages createPackages;
  final MyPackages  myPackages;
  final UpdateProfileCase updateProfileCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  const MyApp({
    super.key,
    required this.registerUseCase,
    required this.otpUseCase,
    required this.loginUseCase,
    required this.profileCase,
    required this.createPackages,
    required this.myPackages,
    required this.updateProfileCase,
    required this.forgotPasswordUseCase

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
        BlocProvider(
          create: (_) => CreatePackageCubit(createPackages),
        ),
        BlocProvider(
          create: (_) => MyPackageCubit(myPackages),
        ),
        BlocProvider(
          create: (_) => UpdateProfileCubit(updateProfileCase),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(forgotPasswordUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

