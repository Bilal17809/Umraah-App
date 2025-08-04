import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../reset_password/view/reset_password_view.dart';
import '../bloc/forgot_password_cubit.dart';
import '../bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.isSuccess && state.emailSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Reset link sent to your email")),
          );

          final email = emailController.text.trim();
          if (email.isNotEmpty) {
            // Navigate to ResetPasswordScreen without token (user will enter token manually)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ResetPasswordScreen(),
              ),
            );
          }
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Forgot Password")),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 20),
                state.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isNotEmpty) {
                      context
                          .read<ForgotPasswordCubit>()
                          .sendResetLink(email);
                    }
                  },
                  child: const Text("Send Reset Link"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

