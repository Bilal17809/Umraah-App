
import 'package:flutter/material.dart';
import 'package:umraah_app/core/common/custom_text_form_field.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import 'package:umraah_app/presentation/home/view/new_account_create_view/view/new_account_create_view.dart';

class SignUpView extends StatelessWidget {
   SignUpView({super.key});

  final nameController =  TextEditingController();
  final emailController =  TextEditingController();
  final passwordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
      ),
      backgroundColor: kWhite,
body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Sign Up",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),

      SizedBox(height: 20),
         _sighnUpForm(hintTitle: "Name",
         controller: nameController,
         ),
         SizedBox(height: 20),
         _sighnUpForm(hintTitle: "Email",
         controller: emailController,
         ),
         SizedBox(height: 20),
         _sighnUpForm(hintTitle: "Password",
         controller: passwordController,
         ),
           

            SizedBox(height: 20),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewAccountCreateView()),
                  );
                },
                child: const Text("Sign Up"),
              ),
                SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                 GestureDetector(
                  onTap: () {
                    
                  },
                  child: Text("Log in",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),))
                ],
              )
    ],
  ),
),
    );
  }
}



class _sighnUpForm extends StatelessWidget {
  final String hintTitle;
  final IconData? icon;
  final TextEditingController? controller;
  _sighnUpForm({
    super.key,
    required this.hintTitle,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: hiegt * 0.09,
      width: double.infinity,
      decoration: roundedDecoration,
      child: Center(
        child: CustomTextFormField(
          suffixIcon: Icon(icon, color: greyBorderColor),
          hintText: hintTitle,
          controller: controller,
        ),
      ),
    );
  }
}