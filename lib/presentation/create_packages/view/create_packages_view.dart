import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import '../bloc/create_package_cubit.dart';
import '../bloc/create_package_state.dart';
import '/domain/entities/create_package_entity.dart';

class CreatePackagesView extends StatefulWidget {
  const CreatePackagesView({super.key});

  @override
  State<CreatePackagesView> createState() => _CreatePackagesViewState();
}

class _CreatePackagesViewState extends State<CreatePackagesView> {
  final _formKey = GlobalKey<FormState>();

  final packageNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final noOfDaysController = TextEditingController();
  final startDateController = TextEditingController();
  final makkahHotelNameController = TextEditingController();
  final makkahHotelDistanceController = TextEditingController();
  final makkahHotelRatingController = TextEditingController();
  final madinaHotelNameController = TextEditingController();
  final madinaHotelDistanceController = TextEditingController();
  final madinaHotelRatingController = TextEditingController();
  final flightNumberController = TextEditingController();
  final airLineController = TextEditingController();
  final sharedPriceController = TextEditingController();
  final triplePriceController = TextEditingController();
  final doublePriceController = TextEditingController();
  final packageIncludeController = TextEditingController();

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

  void pickDate({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate.toIso8601String().split('T').first;
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Package",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 10),

                // Image picker
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
                                  Icon(
                                    Icons.image,
                                    color: greyBorderColor,
                                    size: 34,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Add Image",
                                    style: TextStyle(
                                      color: greyBorderColor,
                                      fontSize: 16,
                                    ),
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

                // Form Fields
                _BuildFormField(
                  controller: packageNameController,
                  label: "Package Name",
                ),
                _BuildFormField(controller: priceController, label: "Price"),
                _BuildFormField(
                  controller: noOfDaysController,
                  label: "No of Days",
                ),
                _BuildFormField(
                  controller: startDateController,
                  label: "Start Date (YYYY-MM-DD)",
                  suffixicon: Icon(
                    Icons.date_range_rounded,
                    color: Colors.grey,
                    
                  ),
                  onSuffixTap:
                      () => pickDate(
                        context: context,
                        controller: startDateController,
                      ),
                ),
                _BuildFormField(
                  controller: makkahHotelNameController,
                  label: "Makkah Hotel Name",
                ),
                _BuildFormField(
                  controller: makkahHotelDistanceController,
                  label: "Makkah Hotel Distance (e.g 500m)",
                ),
                _BuildFormField(
                  controller: makkahHotelRatingController,
                  label: "Makkah Hotel Rating (e.g 4.5)",
                ),
                _BuildFormField(
                  controller: madinaHotelNameController,
                  label: "Madina Hotel Name",
                ),
                _BuildFormField(
                  controller: madinaHotelDistanceController,
                  label: "Madina Hotel Distance",
                ),
                _BuildFormField(
                  controller: madinaHotelRatingController,
                  label: "Madina Hotel Rating (e.g. 4.2)",
                ),
                _BuildFormField(
                  controller: flightNumberController,
                  label: "Flight Number",
                ),
                _BuildFormField(
                  controller: airLineController,
                  label: "Airline",
                ),
                _BuildFormField(
                  controller: sharedPriceController,
                  label: "Shared Price",
                ),
                _BuildFormField(
                  controller: triplePriceController,
                  label: "Triple Price",
                ),
                _BuildFormField(
                  controller: doublePriceController,
                  label: "Double Price",
                ),
                _BuildFormField(
                  controller: packageIncludeController,
                  label: "Package Includes (comma-separated)",
                ),
                _BuildFormField(
                  controller: descriptionController,
                  label: "Description",
                  maxLines: 4,
                  borderRadius: 12,
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
                    if (_formKey.currentState!.validate()) {
                      final cubit = context.read<CreatePackageCubit>();
                      final entity = CreatePackageEntity(
                        noOfDays: int.tryParse(noOfDaysController.text) ?? 0,
                        startDate: startDateController.text,
                        makkahHotelName: makkahHotelNameController.text,
                        makkahHotelDistance: makkahHotelDistanceController.text,
                        makkahHotelRating:
                            double.tryParse(makkahHotelRatingController.text) ??
                            0.0,
                        madinaHotelName: madinaHotelNameController.text,
                        madinaHotelDistance: madinaHotelDistanceController.text,
                        madinaHotelRating:
                            double.tryParse(madinaHotelRatingController.text) ??
                            0.0,
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
                    }
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


class _BuildFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final int? maxLines;
  final double? borderRadius;
  final Widget? suffixicon;
  final VoidCallback? onSuffixTap;
  const _BuildFormField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.maxLines,
    this.borderRadius,
    this.suffixicon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FormField<String>(
        validator:
            (val) =>
                controller.text.trim().isEmpty ? 'Please enter $label' : null,
        builder: (field) {
          final hasError = field.hasError;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: roundedDecoration.copyWith(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius ?? 35),
                ),
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  maxLines: maxLines,
                  readOnly: onSuffixTap != null,
                  onTap: onSuffixTap,
                  onChanged: field.didChange,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon:
                        suffixicon != null
                            ? GestureDetector(
                              onTap: onSuffixTap,
                              child: suffixicon,
                            )
                            : null,
                    hintText: label,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 08),
                  ),
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
