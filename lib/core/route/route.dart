import 'package:flutter/material.dart';

import 'package:umraah_app/core/route/route_name.dart';
import 'package:umraah_app/presentation/active_packages/view/active_package_view.dart';
import 'package:umraah_app/presentation/home/view/dashboard_view/view/dashboard_view.dart';
import 'package:umraah_app/presentation/login/view/login_view.dart';
import 'package:umraah_app/presentation/profile/view/profile_view.dart';
import 'package:umraah_app/presentation/splash/view/splash_view.dart';
import 'package:umraah_app/presentation/user_type/view/user_type.dart';
import 'package:umraah_app/presentation/verify_otp/view/verify_otp_view.dart';
import '/presentation/agency_dashboard/view/agency_dashboard_view.dart';
import '/presentation/forgot_password/view/forgot_password_view.dart';
import '/presentation/signup/view/signup_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesName.userTypePage:
        return MaterialPageRoute(builder: (_) => const UserType());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RoutesName.signUpPage:
        final userType=arguments as String;
        return MaterialPageRoute(builder: (_) =>  SignupView());
      case RoutesName.loginPage:
        final userType= settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  LoginView(userType: userType,));
      case RoutesName.userDashboard:
        return MaterialPageRoute(builder: (_) => const UserDashboardView());
      case RoutesName.agencyDashboard:
        return MaterialPageRoute(builder: (_) => const AgencyDashboardScreen());
      case RoutesName.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutesName.activePackage:
        return MaterialPageRoute(builder: (_) => const ActivePackageView());
      case RoutesName.otpPage:
        final args = settings.arguments as Map<String, String>;
        final email = args['email'] ?? '';
        final useType = args['useType'] ?? '';
        return MaterialPageRoute(
          builder: (_) => OtpVerifyScreen(email: email, useType: useType),
        );

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