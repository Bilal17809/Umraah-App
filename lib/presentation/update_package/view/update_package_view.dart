import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/data/model/create_package.dart';

import '../../../domain/entities/create_package_entity.dart';
import '../../signup/widgets/signup_form.dart';
import '../bloc/update_package_cubit.dart';
import '../bloc/update_package_state.dart';

class UpdatePackageScreen extends StatefulWidget {
  final String packageId;
  final CreatePackageModel existingData;

  const UpdatePackageScreen({
    super.key,
    required this.packageId,
    required this.existingData,
  });

  @override
  State<UpdatePackageScreen> createState() => _UpdatePackageScreenState();
}

class _UpdatePackageScreenState extends State<UpdatePackageScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController makkahHotelNameController;
  late TextEditingController startDateController;
  late TextEditingController daysController;

  @override
  void initState() {
    super.initState();
    makkahHotelNameController =
        TextEditingController(text: widget.existingData.makkahHotelName);
    startDateController =
        TextEditingController(text: widget.existingData.startDate);
    daysController =
        TextEditingController(text: widget.existingData.noOfDays.toString());
  }

  @override
  void dispose() {
    makkahHotelNameController.dispose();
    startDateController.dispose();
    daysController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (!_formKey.currentState!.validate()) return;

    final updatedPackage = CreatePackageEntity(
      makkahHotelName: makkahHotelNameController.text,
      startDate: startDateController.text,
      noOfDays: int.tryParse(daysController.text) ?? 0,
      makkahHotelDistance: '',
      makkahHotelRating:2.3,
      madinaHotelName: '',
      madinaHotelDistance: '',
      madinaHotelRating: 1.2,
      detail: '',
      flightNumber: '',
      airLine: '',
      packageImage: '',
      packageSharedPrice: '',
      packageTriplePrice: '',
      packageDoublePrice: '',
      packageInclude: '', packId: '',
    );

    context.read<UpdatePackageCubit>().update('${widget.packageId}', updatedPackage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Package')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<UpdatePackageCubit, UpdatePackageState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pop(context, true); // return to previous screen
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  BuildFormField(
                    label: "Makkah Hotel Name",
                    controller: makkahHotelNameController,
                  ),
                  const SizedBox(height: 12),
                  BuildFormField(
                    label: "Start Date",
                    controller: startDateController,
                  ),
                  const SizedBox(height: 12),
                  BuildFormField(
                    label: "No of Days",
                    controller: daysController,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.isLoading ? null : _submitUpdate,
                    child: const Text("Update Package"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
