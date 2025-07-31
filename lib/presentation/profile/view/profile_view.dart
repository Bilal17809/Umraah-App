import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/route/route.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '/core/route/route_name.dart';
import '/core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const UpdateProfile(),
                                ),
                              );
                            },
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
                          const _CellTitle(title: 'Help & Feedback'),
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

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kWhite,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          final user = state.profileData?['user'];

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.24,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.14),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.10),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          _ProfileRow(title: user?['firstName'] ?? 'N/A', icon: Icons.edit),
                          SizedBox(height: height * 0.03),
                          _ProfileRow(title: user?['lastName'] ?? 'N/A', icon: Icons.edit),
                          SizedBox(height: height * 0.03),
                          _ProfileRow(title: user?['email'] ?? 'N/A', icon: Icons.edit),
                          SizedBox(height: height * 0.03),
                          _ProfileRow(title: user?['userType'] ?? 'N/A', icon: Icons.edit),
                          SizedBox(height: height * 0.03),
                          _ProfileRow(title: user?['phoneNumber'] ?? 'N/A', icon: Icons.edit),
                          SizedBox(height: height * 0.04),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      onPressed: () {
                        // Change action
                      },
                      child: const Text("Change"),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: height * 0.12,
                left: (width - (height * 0.20)) / 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: height * 0.20,
                      width: height * 0.20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Center(
                        child: _profileImage == null
                            ? const Icon(Icons.person, size: 80, color: Colors.grey)
                            : ClipOval(
                          child: Image.file(
                            _profileImage!,
                            height: height * 0.20,
                            width: height * 0.20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImageFromGallery,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
                          ),
                          child: Icon(Icons.camera_alt, size: 18, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _ProfileRow({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        height: height * 0.10,
        width: double.infinity,
        decoration: roundedDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
              GestureDetector(onTap: onTap, child: Icon(icon, color: greyBorderColor)),
            ],
          ),
        ),
      ),
    );
  }
}
