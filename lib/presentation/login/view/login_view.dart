
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../agency_tab/view/agency_tab_view.dart';
import '/core/common/custom_text_form_field.dart';
import '/core/theme/app_styles.dart';
import '../../home/view/tab_bar_view/view/tab_bar_view.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_theme.dart';
import '/domain/entities/user_entities.dart';
import '../../home/view/sign_up_view/view/sign_up_view.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful")),
            );
            if(widget.userType=='2'){
              print('##################${widget.userType}');
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>
                  AgencyTabView()));
            }
            else{
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>
                  AgencyDashboardScreen()));
            }
          } else if (state.errorMessage != null) {
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
                  buildField(emailController, 'Email'),
                  buildField(passwordController, 'Password', obscureText: true),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpView()),
                          );
                        },
                        child: const Text("Sign Up", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildField(
      TextEditingController controller,
      String label, {
        bool obscureText = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FormField<String>(
        validator: (val) =>
        controller.text.trim().isEmpty ? 'Please enter $label' : null,
        builder: (field) {
          final hasError = field.hasError;
          controller.addListener(() {
            field.didChange(controller.text);
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: roundedDecoration.copyWith(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: hasError ? Colors.red : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: CustomTextFormField(
                  hintText: label,
                  controller: controller,
                  obscureText: obscureText,
                  // Optional: also forward this
                  onChanged: (_) => field.didChange(controller.text),
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 6),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

}

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void _submitLogin() {
//     final loginData = LoginEntity(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );
//
//     context.read<LoginCubit>().login(loginData);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state.isSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Login Successful")),
//             );
//             // Navigate to home or next screen
//           } else if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errorMessage!)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: emailController,
//                   decoration: const InputDecoration(labelText: "Email"),
//                 ),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(labelText: "Password"),
//                 ),
//                 const SizedBox(height: 20),
//                 state.isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                   onPressed: _submitLogin,
//                   child: const Text("Login"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
