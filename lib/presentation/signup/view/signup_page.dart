import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/login/view/login_view.dart';
import 'package:umraah_app/presentation/profile/view/profile_view.dart';
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
      appBar: AppBar(title: const Text('Register User'),
          actions: [
            IconButton(onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)
              =>ProfileScreen()));
            }, icon:Icon(Icons.account_balance_sharp))
        ],
      ),
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
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildField(firstName, 'First Name'),
                    buildField(lastName, 'Last Name'),
                    buildField(email, 'Email'),
                    buildField(password, 'Password', obscureText: true),
                    buildField(phoneNumber, 'Phone Number'),
                    buildField(agencyName, 'Agency Name'),
                    buildField(agencyAddress, 'Agency Address'),
                    buildField(agencyLicenceNumber, 'Licence Number'),
                    const SizedBox(height: 20),
                    ElevatedButton(
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
                        Navigator.of(context).push(MaterialPageRoute(builder:(context){
                          return LoginView();
                        }));
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

  Widget buildField(TextEditingController ctrl, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
