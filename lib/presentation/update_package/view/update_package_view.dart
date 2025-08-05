import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/data/model/create_package.dart';

import '../../../core/common/primary_button.dart';
import '/core/theme/app_styles.dart';
import '/core/util/loader_dialog.dart';
import '/core/util/toast_message.dart';
import '/domain/entities/create_package_entity.dart';
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

  late TextEditingController makkahHotelName;
  late TextEditingController makkaHotelDistance;
  late TextEditingController makkaHotelRating;
  late TextEditingController madinaHotelName;
  late TextEditingController madinaHotelDistance;
  late TextEditingController madinaHotelRating;

  late TextEditingController flightNumber;
  late TextEditingController airline;
  late TextEditingController sharePrice;
  late TextEditingController triplePrice;
  late TextEditingController doublePrice;
  late TextEditingController packageIncluded;

  @override
  void initState() {
    super.initState();
    makkahHotelNameController =
        TextEditingController(text: widget.existingData.makkahHotelName);
    startDateController =
        TextEditingController(text: widget.existingData.startDate);
    daysController =
        TextEditingController(text: widget.existingData.noOfDays.toString());

    makkahHotelName = TextEditingController(text: widget.existingData.makkahHotelName.toString());
    makkaHotelDistance = TextEditingController(text: widget.existingData.makkahHotelDistance.toString());
    makkaHotelRating = TextEditingController(text: widget.existingData.makkahHotelRating.toString());

    madinaHotelName = TextEditingController(text: widget.existingData.madinaHotelName.toString());
    madinaHotelDistance = TextEditingController(text: widget.existingData.madinaHotelDistance.toString());
    madinaHotelRating = TextEditingController(text: widget.existingData.madinaHotelDistance.toString());

    flightNumber = TextEditingController(text: widget.existingData.flightNumber.toString());
    airline = TextEditingController(text: widget.existingData.airLine.toString());
    sharePrice = TextEditingController(text: widget.existingData.packageSharedPrice.toString());
    triplePrice = TextEditingController(text: widget.existingData.packageTriplePrice.toString());
    doublePrice = TextEditingController(text: widget.existingData.packageDoublePrice.toString());
    packageIncluded = TextEditingController(text: widget.existingData.packageInclude.toString());
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

    context.read<UpdatePackageCubit>().update(widget.packageId, updatedPackage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Update Package',style: titleMediumStyle,)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<UpdatePackageCubit, UpdatePackageState>(
          listener: (context, state) {
            if (state.isLoading) {
             LoaderDialog().showLoaderDialog(context);
            }
            else {
              LoaderDialog().hideLoaderDialog(context);
              if (state.isSuccess) {
                showToast(context, 'Package updated successfully', Colors.green);
              } else if (state.errorMessage != null) {
                showToast(context, 'Update failed', Colors.red);
              }
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
                  BuildFormField(
                    label: "Start Date",
                    controller: startDateController,
                  ),
                  BuildFormField(
                    label: "No of Days",
                    controller: daysController,
                  ),
                  BuildFormField(
                    label: "Makkah Hotel Name",
                    controller: makkahHotelName,
                  ),
                  BuildFormField(
                    label: "Makkah Hotel Distance",
                    controller: makkaHotelDistance,
                  ),
                  BuildFormField(
                    label: "Makkah Hotel Rating",
                    controller: makkaHotelRating,
                  ),
                  BuildFormField(
                    label: "Madina Hotel Name",
                    controller: madinaHotelName,
                  ),
                  BuildFormField(
                    label: "Madina Hotel Distance",
                    controller: madinaHotelDistance,
                  ),
                  BuildFormField(
                    label: "Flight Number",
                    controller: flightNumber,
                  ),
                  const SizedBox(height: 12),
                  BuildFormField(
                    label: "Shared Price",
                    controller: sharePrice,
                  ),
                  BuildFormField(
                    label: "Triple Price",
                    controller: triplePrice,
                  ),
                  BuildFormField(
                    label: "Double Price",
                    controller:doublePrice,
                  ),
                  BuildFormField(
                    label: "Package Included",
                    controller:packageIncluded,
                  ),
                  SizedBox(height: 20,),
                  PrimaryButton(
                    text: 'Update Package',
                    onTap:(){
                      state.isLoading ? null : _submitUpdate();
                    },
                  ),
                  SizedBox(height: 12,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
