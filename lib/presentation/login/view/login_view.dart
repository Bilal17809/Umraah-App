import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/route/route_name.dart';
import '/core/local_data_storage/local_storage.dart';
import '../../signup/widgets/signup_form.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_theme.dart';
import '/domain/entities/user_entities.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginView extends StatefulWidget {
  final String userType;
  const LoginView({super.key,required this.userType});

  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final loginData = LoginEntity(
        email: emailController.text,
        password: passwordController.text,
      );
      context.read<LoginCubit>().login(loginData);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kWhite),
      backgroundColor: kWhite,
      body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              SecureStorage.saveType(widget.userType);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful")),
              );
              if (widget.userType == '2') {
                Navigator.pushNamed(context, RoutesName.agencyDashboard);
              } else {
                Navigator.pushNamed(context, RoutesName.userDashboard);
              }
            } else if (!state.isSuccess) {
              // 👈 only show error if success has NOT happened
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Log In", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  BuildFormField(controller:emailController, label: 'Email'),
                  BuildFormField(controller:passwordController,label:'Password', obscureText: true),
                  const SizedBox(height: 20),
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    style: AppTheme.elevatedButtonStyle.copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: _submitLogin,
                    child: const Text("Log In"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                         Navigator.pushNamed(context,
                             RoutesName.signUpPage,
                           arguments: widget.userType
                         );
                        },
                        child: const Text("Sign Up", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 12,),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,RoutesName.forgotPassword);
                        },
                        child: const Text("Forget Password", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
