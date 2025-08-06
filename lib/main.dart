import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/repositories/repositories.dart';
import 'package:umraah_app/domain/use-cases/create_packages.dart';
import 'package:umraah_app/domain/use-cases/forgot_password_case.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/domain/use-cases/reset_password.dart';
import 'package:umraah_app/domain/use-cases/update_profile.dart';
import 'package:umraah_app/presentation/create_packages/bloc/create_package_cubit.dart';
import 'package:umraah_app/presentation/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_package_cubit.dart';
import 'package:umraah_app/presentation/reset_password/bloc/reset_password_cubit.dart';
import 'package:umraah_app/presentation/update_package/bloc/update_package_cubit.dart';
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
import 'domain/use-cases/delete_package_case.dart';
import 'domain/use-cases/update_package.dart';


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import '../../../core/util/loader_dialog.dart';
import '../../../core/util/toast_message.dart';
import '/domain/entities/create_package_entity.dart';
import 'package:http/http.dart' as http;


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
  final myPackage = MyPackagesUseCase(userRepository);
  final forgotPassword = ForgotPasswordUseCase(userRepository);
  final resetPassword = ResetPasswordCase(userRepository);
  final updatePackage = UpdatePackageCase(userRepository);
  final deletePackages = DeletePackageCase(userRepository);

  runApp(MyApp(
    registerUseCase: registerUseCase,
    otpUseCase: otpUseCase,
    loginUseCase: loginUseCase,
    profileCase: profileCase,
    createPackages: createPackages,
    myPackages: myPackage,
    updateProfileCase: updateProfileCase,
    forgotPasswordUseCase: forgotPassword,
    resetPasswordCase: resetPassword,
    updatePackageCase: updatePackage,
    deletePackageCase: deletePackages,
  ));
}

class MyApp extends StatelessWidget {
  final SignupUseCase registerUseCase;
  final OtpVerifyUseCase otpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileCase;
  final CreatePackages createPackages;
  final MyPackagesUseCase  myPackages;
  final UpdateProfileCase updateProfileCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordCase resetPasswordCase;
  final UpdatePackageCase updatePackageCase;
  final DeletePackageCase deletePackageCase;

  const MyApp({
    super.key,
    required this.registerUseCase,
    required this.otpUseCase,
    required this.loginUseCase,
    required this.profileCase,
    required this.createPackages,
    required this.myPackages,
    required this.updateProfileCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordCase,
    required this.updatePackageCase,
    required this.deletePackageCase

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
          create: (_) => MyPackageCubit(myPackages,deletePackageCase),
        ),
        BlocProvider(
          create: (_) => UpdateProfileCubit(updateProfileCase),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(forgotPasswordUseCase),
        ),
        BlocProvider(
          create: (_) => ResetPasswordCubit(resetPasswordCase),
        ),
        BlocProvider(
          create: (_) => UpdatePackageCubit(updatePackageCase),
        ),
        BlocProvider(
          create: (_) => UpdatePackageCubit(updatePackageCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: UploadScreen(),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}



