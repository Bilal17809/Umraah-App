import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/common/custom_text_form_field.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import 'package:umraah_app/presentation/home/view/tab_bar_view/view/tab_bar_view.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_cubit.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_state.dart';
import '../../verify_otp/view/verify_otp_view.dart';
import '/domain/entities/user_entities.dart';

class SignupView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final agencyName = TextEditingController();
  final agencyAddress = TextEditingController();
  final agencyLicenceNumber = TextEditingController();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(title: const Text('Register User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state.isSuccess) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Success"),
                    content: const Text("Registered successfully!"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              } else if (state.hasError) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.errorMessage ?? "Something went wrong"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                  children: [
                  buildField(firstName, "First Name"),
                    buildField(lastName, 'Last Name'),
                    buildField(email, 'Email'),
                    buildField(password, 'Password', obscureText: true),
                    buildField(phoneNumber, 'Phone Number'),
                    buildField(agencyName, 'Agency Name'),
                    buildField(agencyAddress, 'Agency Address'),
                    buildField(agencyLicenceNumber, 'Licence Number'),
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
                    onPressed:
                        state.isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          final user = UserEntity(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            email: email.text,
                            password: password.text,
                            phoneNumber: phoneNumber.text,
                            agencyName: agencyName.text,
                            agencyAddress: agencyAddress.text,
                            agencyLicenceNumber:
                            agencyLicenceNumber.text,
                            userImageBase64: "",
                          );
                          cubit.signUp(user);
                        }
                        Navigator.of(context).push(MaterialPageRoute(builder:(context){
                          return OtpVerifyScreen();
                        }));
                      },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Register'),
                  ),
                    TextButton(
                      onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AgencyDashboardScreen();
                          },
                        ),
                      );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup button clicked")),
                        );
                      },
                      child: const Text("Already registered? Login"),
                    ),
                ],
              );
              
            },
          ),
        ),
      ),
    );
  }

  Widget buildField(
    TextEditingController ctrl,
    String label,
    // String hintText,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 06,vertical: 10),
      child: Container(
        height: 64,
        width: double.infinity,
        decoration: roundedDecoration.copyWith(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: CustomTextFormField(
              hintText: label,
              controller: ctrl,
              obscureText: obscureText,
              validator:
                  (val) => val == null || val.isEmpty ? "Enter $label" : null,
            ),
          ),
        ),
      ),
    );
  }
}
