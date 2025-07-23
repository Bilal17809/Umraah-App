import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/usecases/users_case.dart';
import 'package:umraah_app/presentation/signup/cubit/signup_cubit.dart';
import 'package:umraah_app/presentation/signup/view/signup_page.dart';

import 'core/network/network_response.dart';
import 'data/data_source/network_data_sr.dart';
import 'data/repositories_impl/repositories_impl.dart';

void main() {
  // ✅ Build the dependency chain
  final apiClient = ApiClient();
  final remoteDataSource = AuthRemoteDataSource(apiClient);
  final userRepository = UserRepositoryImpl(remoteDataSource);
  final registerUseCase = RegisterUserUseCase(userRepository);

  runApp(MyApp(registerUseCase: registerUseCase));
}

class MyApp extends StatelessWidget {
  final RegisterUserUseCase registerUseCase;

  const MyApp({super.key, required this.registerUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterCubit(registerUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Umrah App',
        home: RegisterScreen(),
      ),
    );
  }
}
