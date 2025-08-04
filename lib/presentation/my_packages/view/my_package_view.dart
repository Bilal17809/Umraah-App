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

            if (state.isSuccess && state.data != null && state.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: state.data!.length,
                itemBuilder: (context, index) {
                  final package = state.data![index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: package.packageImage != null && package.packageImage!.isNotEmpty
                          ? Image.network(package.packageImage!, width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image),
                      title: Text(package.packageName ?? "Unnamed Package"),
                      subtitle: Text("Price: ${package.price ?? 'N/A'} | Days: ${package.noOfDays}"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // optional: navigate to package detail
                      },
                    ),
                  );
                },
              );
            }

            if (state.isSuccess && (state.data == null || state.data!.isEmpty)) {
              return const Center(child: Text("No packages found."));
            }

            return Center(
              child: ElevatedButton(
                onPressed: () => cubit.myPackages(status: 3),
                child: const Text("Load My Packages"),
              ),
            );
          },
        ),
      ),
    );
  }
}
