import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/use-cases/create_packages.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/presentation/create_packages/bloc/create_package_cubit.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_package_cubit.dart';
import 'package:umraah_app/presentation/user_type/view/user_type.dart';
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
import 'core/route/route.dart';
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
  final createPackages = CreatePackages(userRepository);
  final myPackage = MyPackages(userRepository);

  runApp(MyApp(
    registerUseCase: registerUseCase,
    otpUseCase: otpUseCase,
    loginUseCase: loginUseCase,
      profileCase: profileCase,
    createPackages: createPackages,
    myPackages: myPackage,
  ));
}

class MyApp extends StatelessWidget {
  final SignupUseCase registerUseCase;
  final OtpVerifyUseCase otpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileCase;
  final CreatePackages createPackages;
  final MyPackages  myPackages;

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
        BlocProvider(
          create: (_) => CreatePackageCubit(createPackages),
        ),
        BlocProvider(
          create: (_) => MyPackageCubit(myPackages),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.userTypePage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

