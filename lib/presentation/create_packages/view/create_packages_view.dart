import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:umraah_app/core/local_data_storage/local_storage.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import '../../../core/util/loader_dialog.dart';
import '../../../core/util/toast_message.dart';
import '../bloc/create_package_cubit.dart';
import '../bloc/create_package_state.dart';
import '/domain/entities/create_package_entity.dart';
import 'package:http/http.dart' as http;

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
        if (state.isLoading) {
          LoaderDialog().showLoaderDialog(context);
        }
        else{
          LoaderDialog().hideLoaderDialog(context);
          if (state.isSuccess) {
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
            showToast(context, 'Package Created successfully', Colors.green);
          }
          else if (state.errorMessage != null) {
            showToast(context, 'create failed', Colors.red);
          }
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

                TextButton(onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>
                  UploadScreen()));
                }, child:Text("image uplaod"))
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





class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}



class _UploadScreenState extends State<UploadScreen> {
  XFile? _image;

  // ✅ Image Picker Function
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  // ✅ Upload with Base64
  Future<void> uploadPackageWithBase64(File imageFile) async {
    final uri = Uri.parse("https://appsolace.com/umrahApi/public/api/createPackage");
    final token = await SecureStorage.getToken();

    print("📸 Image Path: ${_image?.path}");

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Token not found')),
      );
      return;
    }
    final fileExtension = _image!.path.split('.').last;
    final mimeType = 'image/$fileExtension'; // e.g., 'image/jpeg'

// 2. Convert image to Base64
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

// 3. (CORRECTION) Add the data URI prefix
    final base64WithPrefix = 'data:$mimeType;base64,$base64Image';
    // ✅ Convert image to Base64
    // final bytes = await imageFile.readAsBytes();
    // final base64Image = base64Encode(bytes); // 👈 Pure Base64 string, no data:image prefix

    print("🧪 Base64 Image String (shortened): ${base64Image.substring(0, 100)}...");

    // ⚠️ IMPORTANT: This body now matches the 'createPackage' API's expected structure
    final body = {
      "title": "My Awesome Umrah Package", // Added: A title for the package
      "price": 5000, // Added: Price for the package (as a number)
      "agencyId": 123, // Added: Agency ID (as a number)
      "noOfDays": 10, // Changed to int
      "startDate": "2025-08-08",
      "makkahHotelName": "Pakistan package",
      "makkahHotelDistance": "500m", // Keep as string if API expects "500m"
      "makkahHotelRating": 5.0, // Changed to double
      "madinaHotelName": "Good package",
      "madinaHotelDistance": "300m", // Keep as string if API expects "300m"
      "madinaHotelRating": 4.0, // Changed to double
      "detail": "This package includes everything needed for a comfortable trip.",
      "flightNumber": "SV102",
      "airLine": "Saudia Airlines",
      "packageImage": base64WithPrefix, // Your Base64 image
      "packageSharedPrice": 1500, // Changed to int
      "packageTriplePrice": 2000, // Changed to int
      "packageDoublePrice": 2500, // Changed to int
      "packageInclude": "Flights, Hotels, Transport, Meals", // Added: Package inclusions
      // Remove any fields not explicitly required by 'createPackage' API
      // e.g., "packId", "userId", "status", "isFeatured", "createdAt"
      // unless your backend developer confirms they are client-sent.
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print("✅ Status Code: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Package uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Upload failed: ${response.statusCode} - ${response.body}')),
        );
      }
    } catch (e) {
      print("❌ Exception during upload: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception: $e')),
      );
    }
  }

  // ✅ UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Umrah Package")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_image != null)
              Image.file(File(_image!.path), height: 150),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  uploadPackageWithBase64(File(_image!.path));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pick an image first')),
                  );
                }
              },
              child: Text("Upload Package"),
            ),
          ],
        ),
      ),
    );
  }
}







