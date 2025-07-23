import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final agencyName = TextEditingController();
  final agencyAddress = TextEditingController();
  final agencyLicenceNumber = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RegisterCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Register User')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Success"),
                    content: Text("Registered successfully!"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      )
                    ],
                  ),
                );
              } else if (state is RegisterFailure) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Error"),
                    content: Text(state.error),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
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
                    SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: () => cubit.pickUserImage(),
                    //   child: Text(cubit.selectedImage == null
                    //       ? "Pick User Image"
                    //       : "Image Selected"),
                    // ),
                    // SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       final imageBase64 = cubit.selectedImage != null
                    //           ? cubit.encodeImage(cubit.selectedImage!)
                    //           : "";
                    //
                    //       final user = UserModel(
                    //         firstName: firstName.text,
                    //         lastName: lastName.text,
                    //         email: email.text,
                    //         password: password.text,
                    //         phoneNumber: phoneNumber.text,
                    //         agencyName: agencyName.text,
                    //         agencyAddress: agencyAddress.text,
                    //         agencyLicenceNumber: agencyLicenceNumber.text,
                    //         userImageBase64: imageBase64,
                    //       );
                    //
                    //       cubit.registerUser(user);
                    //     }
                    //   },
                    //   child: state is RegisterLoading
                    //       ? CircularProgressIndicator()
                    //       : Text('Register'),
                    // ),
                    // TextButton(
                    //   onPressed: () => Navigator.push(context,
                    //       // MaterialPageRoute(builder: (_) => LoginPage())),
                    //   child: Text("Already registered? Login"),
                    // ),
                      TextButton(onPressed:(){
                        SnackBar(content:Text("signUp successfully"));
                      }, child:Text("SignUp"))
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
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
