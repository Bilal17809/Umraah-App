import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileCubit>().getProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('My Profile'),
//       //   actions: [
//       //     BlocListener<ProfileCubit, ProfileState>(
//       //       listener: (context, state) {
//       //         if (state.isSuccess) {
//       //           ScaffoldMessenger.of(context).showSnackBar(
//       //             SnackBar(content: Text("Logout successful")),
//       //           );
//       //         }
//       //       },
//       //       child: IconButton(
//       //         icon: Icon(Icons.account_balance),
//       //         onPressed: () {
//       //           context.read<ProfileCubit>().logout();
//       //         },
//       //       ),
//       //     ),
//       //   ],
//       //
//       //
//       // ),
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state.errorMessage != null) {
//             return Center(
//               child: Text(
//                 state.errorMessage!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }
//
//           if (state.isSuccess && state.profileData != null) {
//             final profileData = state.profileData;
//
//
//
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//               Text("FName: ${profileData?['user']?['firstName'] ?? 'N/A'}"),
//                   Text("LName: ${profileData?['user']?['lastName'] ?? 'N/A'}"),
//                   Text("UserT: ${profileData?['user']?['userType'] ?? 'N/A'}"),
//                   Text("Phone: ${profileData?['user']?['phoneNumber'] ?? 'N/A'}"),
//               Text("Email: ${profileData?['user']?['email'] ?? 'N/A'}"),
//
//                   // Add more fields
//                 ],
//               ),
//             );
//           }
//
//           return const Center(child: Text("No profile data available."));
//         },
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import '/core/theme/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
