import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../my_packages/bloc/my_package_cubit.dart';
import '../../my_packages/bloc/my_packages_state.dart';

class ActivePackageView extends StatefulWidget {
  const ActivePackageView({super.key});

  @override
  State<ActivePackageView> createState() => _ActivePackageViewState();
}

class _ActivePackageViewState extends State<ActivePackageView> {
  @override
  void initState() {
    super.initState();
    context.read<MyPackageCubit>().myPackages(status: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ],
                ),
              );
            }

            if (state.isSuccess && state.data != null && state.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  // Call your Cubit to reload the data
                  context.read<MyPackageCubit>().myPackages(status: 0);
                },
                child: ListView.builder(
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) {
                    final package = state.data![index];
                    final imageUrl = package.packageImage;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: imageUrl.isNotEmpty
                            ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image),
                        title: Text(package.makkahHotelName.isNotEmpty
                            ? package.makkahHotelName
                            : "Unnamed Package"),
                        subtitle: Text(
                          "Start Date: ${package.packId} | Days: ${package.noOfDays}\n"
                              "Makkah Hotel: ${package.makkahHotelName} (${package.makkahHotelDistance}m, Rating: ${package.makkahHotelRating})\n"
                              "Madina Hotel: ${package.madinaHotelName} (${package.madinaHotelDistance}m, Rating: ${package.madinaHotelRating})",
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'update') {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => UpdatePackageScreen(
                              //       packageId: package.packId,
                              //       existingData: package,
                              //     ),
                              //   ),
                              // );
                            }
                            if(value == 'delete'){
                              context.read<MyPackageCubit>().deletePackage(id:package.packId);
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'update',
                              child: Text('Update Package'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete package'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(child: Text("No packages found."));
          },
        ),
      ),
    );
  }
}
