import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/presentation/profile/view/profile_view.dart';

import '../../create_packages/view/create_packages_view.dart';
import '../../my_packages/view/my_package_view.dart';

class AgencyTabView extends StatelessWidget {
  const AgencyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Packages'),
              Tab(text: 'Create'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            Center(child: Text("Active")),
            MyPackagesView(),
            CreatePackagesView(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

