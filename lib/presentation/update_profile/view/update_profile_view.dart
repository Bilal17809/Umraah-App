import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/route/route_name.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';
import '../../../domain/entities/update_user_profile.dart';
import '../bloc/update_profile_cubit.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // This listener will be called whenever the ProfileCubit's state changes.
          // This is the ideal place to update the text controllers.
          if (state.profileData?['user'] != null) {
            final updatedUser = state.profileData?['user'];
            firstNameController.text = updatedUser['firstName'] ?? '';
            lastNameController.text = updatedUser['lastName'] ?? '';
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _EditableField(controller: firstNameController, label: 'First Name'),
                  _EditableField(controller: lastNameController, label: 'Last Name'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        final currentUser = context.read<ProfileCubit>().state.profileData?['user'];

                        final user = UpdateUserProfileEntity(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phoneNumber: currentUser['phoneNumber'] ?? '',
                          agencyName: currentUser['agencyName'] ?? '',
                          agencyAddress: currentUser['agencyAddress'] ?? '',
                          agencyLicenceNumber: currentUser['agencyLicenceNumber'] ?? '',
                          agencyImage: '',
                          userImage: '',
                        );

                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(child: CircularProgressIndicator()),
                        );

                        final result = await context.read<UpdateProfileCubit>().updateProfile(user);

                        if (context.mounted) Navigator.pop(context); // Close loading

                        if (result != null && result.success) {
                          // Wait for profile to actually reload
                          await context.read<ProfileCubit>().getProfile();

                          // Listen to state update with a delay (hacky but works)
                          Future.delayed(const Duration(milliseconds: 300), () {
                            final updatedUser = context.read<ProfileCubit>().state.profileData?['user'];

                            if (context.mounted && updatedUser != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => UpdatedProfileView(user: updatedUser)),
                              );
                            }
                          });
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result?.message ?? "Failed to update profile")),
                            );
                          }
                        }
                      },
                      child: const Text("Update Profile"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _EditableField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}



class UpdatedProfileView extends StatelessWidget {
  final Map<String, dynamic> user;

  const UpdatedProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Updated Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name: ${user['firstName'] ?? ''}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Last Name: ${user['lastName'] ?? ''}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Phone: ${user['phoneNumber'] ?? ''}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Agency: ${user['agencyName'] ?? ''}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
