import 'package:flutter/material.dart';
import 'package:umraah_app/core/route/route_name.dart';
import 'package:umraah_app/presentation/home/view/dashboard_view/view/dashboard_view.dart';
import 'package:umraah_app/presentation/home/view/sign_up_view/view/sign_up_view.dart';
import 'package:umraah_app/presentation/login/view/login_view.dart';
import 'package:umraah_app/presentation/profile/view/profile_view.dart';
import 'package:umraah_app/presentation/user_type/view/user_type.dart';
import 'package:umraah_app/presentation/verify_otp/view/verify_otp_view.dart';

import '../../presentation/signup/view/signup_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.userTypePage:
        return MaterialPageRoute(builder: (_) => const UserType());
      case RoutesName.signUpPage:
        final userType=arguments as String;
        return MaterialPageRoute(builder: (_) =>  SignupView(userType:userType));
      case RoutesName.loginPage:
        final userType= settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  LoginView(userType: userType,));
      case RoutesName.dashboardPage:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case RoutesName.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutesName.otpPage:
        final email= settings.arguments as String;
        final useType= settings.arguments as String;
        return MaterialPageRoute(builder:(_)=> OtpVerifyScreen(email: email, useType:useType,));
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}