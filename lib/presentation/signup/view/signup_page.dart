import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/route/route_name.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_cubit.dart';
import 'package:umraah_app/presentation/signup/bloc/signup_state.dart';
import '../widgets/signup_form.dart';
import '/domain/entities/user_entities.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_theme.dart';

// class SignupView extends StatelessWidget {
//   final String userType;
//
//   SignupView({super.key, required this.userType});
//
//   final _formKey = GlobalKey<FormState>();
//
//   final firstName = TextEditingController();
//   final lastName = TextEditingController();
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final phoneNumber = TextEditingController();
//   final agencyName = TextEditingController();
//   final agencyAddress = TextEditingController();
//   final agencyLicenceNumber = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<SignupCubit>();
//     final isUser = userType == "1";
//
//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: AppBar(
//         backgroundColor:kWhite,
//       ),
//       body: SingleChildScrollView(
//         child: BlocConsumer<SignupCubit, SignupState>(
//             listener: (context, state) {
//               if (state.isSuccess) {
//                 Navigator.pushNamed(
//                   context,
//                   RoutesName.otpPage,
//                   arguments: {
//                     'email': email.text,
//                     'useType': userType,
//                   },
//                 );
//               } else if (state.errorMessage != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.errorMessage!)),
//                 );
//               }
//             },
//
//             builder: (context, state) {
//             return Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text("Sign Up",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
//                       ],
//                     ),
//                     BuildFormField(controller: firstName, label: "First Name"),
//                     BuildFormField(controller: lastName, label: 'Last Name'),
//                     BuildFormField(controller: email,label: 'Email'),
//                     BuildFormField(controller: password,label: 'Password', obscureText: true),
//                     BuildFormField(controller: phoneNumber, label: 'Phone Number'),
//                     if (!isUser) ...[
//                       BuildFormField(controller: agencyName,label: 'Agency Name'),
//                       BuildFormField(controller: agencyAddress,label: 'Agency Address'),
//                       BuildFormField(controller: agencyLicenceNumber, label: 'Licence Number'),
//                     ],
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       style: AppTheme.elevatedButtonStyle.copyWith(
//                         backgroundColor: MaterialStateProperty.all(Colors.green),
//                         foregroundColor: MaterialStateProperty.all(Colors.white),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                       ),
//                       onPressed: state.isLoading
//                           ? null
//                           : () {
//                         if (_formKey.currentState!.validate()) {
//                           final user = UserEntity(
//                             firstName: firstName.text,
//                             lastName: lastName.text,
//                             email: email.text,
//                             password: password.text,
//                             phoneNumber: phoneNumber.text,
//                             agencyName: isUser ? '' : agencyName.text,
//                             agencyAddress: isUser ? '' : agencyAddress.text,
//                             agencyLicenceNumber:
//                             isUser ? '' : agencyLicenceNumber.text,
//                             userImageBase64: "",
//                             userType:userType,
//                             agencyImageBase64: '',
//                             token: '', isVerified: false,
//                           );
//                           cubit.signUp(user);
//                         }
//                       },
//                       child: state.isLoading
//                           ? const CircularProgressIndicator()
//                           : const Text('Register'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context,
//                             RoutesName.loginPage,
//                           arguments: userType
//                         );
//                       },
//                       child: const Text("Already registered? Login"),
//                     ),
//
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context,
//                             RoutesName.otpPage,
//                           arguments: {
//                             'email': 'bilalkhwar2@gmail.com',
//                             'useType': userType,
//                           },
//                         );
//                       },
//                       child: const Text("Already registered? Login"),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
// }


class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  int _selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final agencyName = TextEditingController();
  final agencyAddress = TextEditingController();
  final agencyLicenceNumber = TextEditingController();

  void _submitForm() {
    final cubit = context.read<SignupCubit>();
    if (_formKey.currentState?.validate() ?? false) {
      final user = UserEntity(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        agencyName: _selectedIndex == 0 ? '' : agencyName.text,
        agencyAddress: _selectedIndex == 0 ? '' : agencyAddress.text,
        agencyLicenceNumber: _selectedIndex == 0 ? '' : agencyLicenceNumber.text,
        userImageBase64: '',
        agencyImageBase64: '',
        userType: _selectedIndex == 0 ? '1' : '2',
        token: '',
        isVerified: false,
      );
      cubit.signUp(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isUser = _selectedIndex == 0;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
        backgroundColor: kWhite,
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushNamed(
              context,
              RoutesName.otpPage,
              arguments: {
                'email': email.text,
                'useType': _selectedIndex == 0 ? '1' : '2',
              },
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              children: [
                const SizedBox(height:16),
                Container(
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      _buildToggleItem("User", 0),
                      _buildToggleItem("Agency", 1),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          if (isUser) ...[
                            BuildFormField(controller: firstName, label: "First Name"),
                            BuildFormField(controller: lastName, label: "Last Name"),
                          ],
                          if (!isUser) ...[
                            BuildFormField(controller: agencyName, label: "Agency Name"),
                            BuildFormField(controller: agencyAddress, label: "Agency Address"),
                            BuildFormField(controller: agencyLicenceNumber, label: "Licence Number"),
                          ],
                          BuildFormField(controller: email, label: "Email"),
                          BuildFormField(controller: password, label: "Password", obscureText: true),
                          BuildFormField(controller: phoneNumber, label: "Phone Number"),

                          const SizedBox(height: 20),

                          ElevatedButton(
                            style: AppTheme.elevatedButtonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: state.isLoading ? null : _submitForm,
                            child: state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text("Register"),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.loginPage,
                                arguments: _selectedIndex == 0 ? '1' : '2',
                              );
                            },
                            child: const Text("Already registered? Login"),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleItem(String label, int index) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected? Colors.white: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected? Colors.black:  Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

