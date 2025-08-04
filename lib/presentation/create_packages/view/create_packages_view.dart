import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';

import '../bloc/create_package_state.dart';
import '/domain/entities/create_package_entity.dart';
import '../bloc/create_package_cubit.dart';



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePackagesView extends StatefulWidget {
  const CreatePackagesView({super.key});

  @override
  State<CreatePackagesView> createState() => _CreatePackagesViewState();
}

class _CreatePackagesViewState extends State<CreatePackagesView> {
  final packageNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController makkahHotelNameController = TextEditingController();
  final TextEditingController makkahHotelDistanceController = TextEditingController();
  final TextEditingController makkahHotelRatingController = TextEditingController();
  final TextEditingController madinaHotelNameController = TextEditingController();
  final TextEditingController madinaHotelDistanceController = TextEditingController();
  final TextEditingController madinaHotelRatingController = TextEditingController();
  final TextEditingController flightNumberController = TextEditingController();
  final TextEditingController airLineController = TextEditingController();
  final TextEditingController sharedPriceController = TextEditingController();
  final TextEditingController triplePriceController = TextEditingController();
  final TextEditingController doublePriceController = TextEditingController();
  final TextEditingController packageIncludeController = TextEditingController();

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    packageNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    noOfDaysController.dispose();
    startDateController.dispose();
    makkahHotelNameController.dispose();
    makkahHotelDistanceController.dispose();
    makkahHotelRatingController.dispose();
    madinaHotelNameController.dispose();
    madinaHotelDistanceController.dispose();
    madinaHotelRatingController.dispose();
    flightNumberController.dispose();
    airLineController.dispose();
    sharedPriceController.dispose();
    triplePriceController.dispose();
    doublePriceController.dispose();
    packageIncludeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener<CreatePackageCubit, CreatePackageState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('🎉 Package created successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Clear form
          packageNameController.clear();
          priceController.clear();
          descriptionController.clear();
          noOfDaysController.clear();
          startDateController.clear();
          makkahHotelNameController.clear();
          makkahHotelDistanceController.clear();
          makkahHotelRatingController.clear();
          madinaHotelNameController.clear();
          madinaHotelDistanceController.clear();
          madinaHotelRatingController.clear();
          flightNumberController.clear();
          airLineController.clear();
          sharedPriceController.clear();
          triplePriceController.clear();
          doublePriceController.clear();
          packageIncludeController.clear();

          setState(() {
            pickedImage = null;
          });
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error: ${state.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Package",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),

                // Image picker container
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: height * 0.18,
                    width: width * 0.34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: greyBorderColor.withOpacity(0.18)),
                    ),
                    child: pickedImage == null
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: greyBorderColor, size: 34),
                          const SizedBox(height: 2),
                          Text(
                            "Add Image",
                            style: TextStyle(color: greyBorderColor, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        pickedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _PostPackageForm(controller: packageNameController, hintTitle: "Package Name"),
                const SizedBox(height: 20),
                _PostPackageForm(controller: priceController, hintTitle: "Price", icon: Icons.attach_money),
                const SizedBox(height: 12),

                _PostPackageForm(controller: noOfDaysController, hintTitle: "No of Days"),
                _PostPackageForm(controller: startDateController, hintTitle: "Start Date (YYYY-MM-DD)"),
                _PostPackageForm(controller: makkahHotelNameController, hintTitle: "Makkah Hotel Name"),
                _PostPackageForm(controller: makkahHotelDistanceController, hintTitle: "Makkah Hotel Distance (e.g. 500m)"),
                _PostPackageForm(controller: makkahHotelRatingController, hintTitle: "Makkah Hotel Rating (e.g. 4.5)"),
                _PostPackageForm(controller: madinaHotelNameController, hintTitle: "Madina Hotel Name"),
                _PostPackageForm(controller: madinaHotelDistanceController, hintTitle: "Madina Hotel Distance"),
                _PostPackageForm(controller: madinaHotelRatingController, hintTitle: "Madina Hotel Rating (e.g. 4.2)"),
                _PostPackageForm(controller: flightNumberController, hintTitle: "Flight Number"),
                _PostPackageForm(controller: airLineController, hintTitle: "Airline"),
                _PostPackageForm(controller: sharedPriceController, hintTitle: "Shared Price"),
                _PostPackageForm(controller: triplePriceController, hintTitle: "Triple Price"),
                _PostPackageForm(controller: doublePriceController, hintTitle: "Double Price"),
                _PostPackageForm(controller: packageIncludeController, hintTitle: "Package Includes (comma-separated)"),

                Container(
                  decoration: roundedDecoration,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                ElevatedButton(
                  style: AppTheme.elevatedButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final cubit = context.read<CreatePackageCubit>();
                    final entity = CreatePackageEntity(
                      noOfDays: int.tryParse(noOfDaysController.text) ?? 0,
                      startDate: startDateController.text,
                      makkahHotelName: makkahHotelNameController.text,
                      makkahHotelDistance: makkahHotelDistanceController.text,
                      makkahHotelRating: double.tryParse(makkahHotelRatingController.text) ?? 0.0,
                      madinaHotelName: madinaHotelNameController.text,
                      madinaHotelDistance: madinaHotelDistanceController.text,
                      madinaHotelRating: double.tryParse(madinaHotelRatingController.text) ?? 0.0,
                      detail: descriptionController.text,
                      flightNumber: flightNumberController.text,
                      airLine: airLineController.text,
                      packageImage: pickedImage?.path ?? '',
                      packageSharedPrice: sharedPriceController.text,
                      packageTriplePrice: triplePriceController.text,
                      packageDoublePrice: doublePriceController.text,
                      packageInclude: packageIncludeController.text,
                      packId: '',
                    );
                    cubit.createPackage(entity);
                  },
                  child: const Text("Post Package"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostPackageForm extends StatelessWidget {
  final String hintTitle;
  final IconData? icon;
  final TextEditingController? controller;
  const _PostPackageForm({
    super.key,
    required this.hintTitle,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.09,
      decoration: roundedDecoration,
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintTitle,
            suffixIcon: icon != null ? Icon(icon, color: greyBorderColor) : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}

