import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/my_package_cubit.dart';
import '../bloc/my_packages_state.dart';


class MyPackagesView extends StatelessWidget {
  const MyPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyPackageCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Packages")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MyPackageCubit, MyPackagesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => cubit.myPackages(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            if (state.isSuccess) {
              // For demo, just show a success message. Replace with actual package list display.
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
                    const SizedBox(height: 12),
                    const Text("Packages loaded successfully!"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<MyPackageCubit>().myPackages(status: 3),
                        child: const Text("Reload"),
                    ),
                  ],
                ),
              );
            }

            // Initial state - show a button to start loading packages
            return Center(
              child: ElevatedButton(
                onPressed: () =>  context.read<MyPackageCubit>().myPackages(status: 3),
                child: const Text("Load My Packages"),
              ),
            );
          },
        ),
      ),
    );
  }
}
