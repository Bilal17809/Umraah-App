import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.isSuccess && state.profileData != null) {
            final profileData = state.profileData;

            

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text("FName: ${profileData?['user']?['firstName'] ?? 'N/A'}"),
                  Text("LName: ${profileData?['user']?['lastName'] ?? 'N/A'}"),
                  Text("UserT: ${profileData?['user']?['userType'] ?? 'N/A'}"),
                  Text("Phone: ${profileData?['user']?['phoneNumber'] ?? 'N/A'}"),
              Text("Email: ${profileData?['user']?['email'] ?? 'N/A'}"),

                  // Add more fields
                ],
              ),
            );
          }

          return const Center(child: Text("No profile data available."));
        },
      ),
    );
  }
}
