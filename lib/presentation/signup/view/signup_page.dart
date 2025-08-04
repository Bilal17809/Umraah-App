import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/route/route_name.dart';
import 'package:umraah_app/presentation/login/view/login_view.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_cubit.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_state.dart';
import 'package:umraah_app/presentation/verify_otp/view/verify_otp_view.dart';
import '../widgets/signup_form.dart';
import '/domain/entities/user_entities.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_theme.dart';

class SignupView extends StatelessWidget {
  final String userType;

  SignupView({super.key, required this.userType});

  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final agencyName = TextEditingController();
  final agencyAddress = TextEditingController();
  final agencyLicenceNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final isUser = userType == "1";

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text('Register as $userType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  Navigator.pushNamed(
                    context,
                    RoutesName.otpPage,
                    arguments: {
                      'email': email.text,
                      'useType': userType,
                    },
                  );
                } else if (state.errorMessage != null) {
                  print("######### ❌ Signup failed: ${state.errorMessage}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },

              builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    BuildFormField(controller: firstName, label: "First Name"),
                    BuildFormField(controller: lastName, label: 'Last Name'),
                    BuildFormField(controller: email,label: 'Email'),
                    BuildFormField(controller: password,label: 'Password', obscureText: true),
                    if (!isUser) ...[
                      BuildFormField(controller: phoneNumber, label: 'Phone Number'),
                      BuildFormField(controller: agencyName,label: 'Agency Name'),
                      BuildFormField(controller: agencyAddress,label: 'Agency Address'),
                      BuildFormField(controller: agencyLicenceNumber, label: 'Licence Number'),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          final user = UserEntity(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            email: email.text,
                            password: password.text,
                            phoneNumber: phoneNumber.text,
                            agencyName: isUser ? '' : agencyName.text,
                            agencyAddress: isUser ? '' : agencyAddress.text,
                            agencyLicenceNumber:
                            isUser ? '' : agencyLicenceNumber.text,
                            userImageBase64: "",
                            userType:userType,
                            agencyImageBase64: '',
                            token: '', isVerified: false,
                          );
                          cubit.signUp(user);
                        }
                      },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            RoutesName.loginPage,
                          arguments: userType
                        );
                      },
                      child: const Text("Already registered? Login"),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            RoutesName.otpPage,
                          arguments: {
                            'email': 'bilalkhwar2@gmail.com',
                            'useType': userType,
                          },
                        );
                      },
                      child: const Text("Already registered? Login"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
