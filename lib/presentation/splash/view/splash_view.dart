import 'package:flutter/material.dart';

import 'package:umraah_app/core/route/route_name.dart';
import '/core/local_data_storage/local_storage.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await SecureStorage.getLoggedInStatus();
    String? token = await SecureStorage.getToken();
    String? userId = await SecureStorage.getUserType();

    if (isLoggedIn && token != null && token.isNotEmpty && userId != null) {
      if (userId == '2') {
        Navigator.pushReplacementNamed(context, RoutesName.agencyDashboard);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.userDashboard);
      }
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.userTypePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Checking login status..."),
      ),
    );
  }
}

