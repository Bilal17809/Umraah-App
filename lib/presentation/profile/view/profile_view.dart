import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import '../../update_profile/view/update_profile_view.dart';
import '/core/route/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      context.read<ProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)));
              }
              final user = state.profileData?['user'];
              final rawUserType = (user?['userType'] ?? '').toString().toUpperCase();
              final int userType = rawUserType == 'AGENT' ? 2 : 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: roundedDecoration,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user?['email'] ?? '',
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 14,
                        children: [
                          const _CellTitle(title: 'Settings'),
                          _AccountCell(
                            icon: Icons.person,
                            title: 'Personal information',
                              onTap: () async {
                                final shouldRefresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const UpdateProfile()),
                                );

                                if (shouldRefresh == true && mounted) {
                                  context.read<ProfileCubit>().getProfile();
                                }
                              }

                          ),
                          _AccountCell(icon: Icons.report, title: 'Report an Issue', onTap: () {}),
                          _AccountCell(icon: Icons.privacy_tip, title: 'Privacy & Security', onTap: () {}),
                          _AccountCell(
                            icon: Icons.delete_forever,
                            title: 'Delete Account',
                            onTap: () {
                              context.read<ProfileCubit>().delete();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesName.userTypePage,
                                    (route) => false,
                                arguments: userType.toString(),
                              );
                            },
                          ),
                          _AccountCell(
                            icon: Icons.logout_outlined,
                            title: 'Logout',
                            onTap: () async {
                              await context.read<ProfileCubit>().logout();
                              if (context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutesName.loginPage,
                                      (route) => false,
                                  arguments: userType.toString(),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
class _AccountCell extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccountCell({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(12),
      color: kWhite,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor.withValues(alpha: 0.2),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(title,),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        onTap: onTap,
      ),
    );
  }
}
class _CellTitle extends StatelessWidget {
  final String title;

  const _CellTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        title.toUpperCase(),
      ),
    );
  }
}

