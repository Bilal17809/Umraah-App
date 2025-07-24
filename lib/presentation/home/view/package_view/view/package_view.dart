import 'package:flutter/material.dart';
import 'package:umraah_app/core/common/custom_text_form_field.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';



class PackageView extends StatelessWidget {
  PackageView({super.key});

  final packageNameController = TextEditingController();
  final priceController = TextEditingController();

  // final packageController = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Agency App"),
        backgroundColor: kWhite,
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Package",
                style: TextStyle( fontWeight: FontWeight.bold,
                  fontSize: 34,)
              ),
              SizedBox(height: 10),
              Container(
                height: hiegt * 0.18,
                width: width * 0.34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: greyBorderColor.withOpacity(0.18)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: greyBorderColor, size: 34),
                      SizedBox(height: 02),
                      Text(
                        "Add Image",
                        style: TextStyle(color: greyBorderColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _postPacakgeForm(
                controller: packageNameController,
                hintTitle: "Package Name",
              ),
              SizedBox(height: 20),
              Container(
                height: hiegt * 0.09,
                width: double.infinity,
                decoration: roundedDecoration,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                                 "Dates",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                           Icon(Icons.date_range, color: greyBorderColor),
                        
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _postPacakgeForm(
                controller: priceController,
                hintTitle: "Price",
                icon: Icons.attach_money,
              ),
              SizedBox(height: 20),
              Container(
                height: hiegt * 0.17,
                width: double.infinity,
                decoration: roundedDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text(
                        "Include Package. confrommation including transportation between hotel and holy sites, and sugeted its.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14),
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
                onPressed: () {},
                child: const Text("Post Package"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _postPacakgeForm extends StatelessWidget {
  final String hintTitle;
  final IconData? icon;
  final TextEditingController? controller;
  _postPacakgeForm({
    super.key,
    required this.hintTitle,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: hiegt * 0.09,
      width: double.infinity,
      decoration: roundedDecoration,
      child: Center(
        child: CustomTextFormField(
          suffixIcon: Icon(icon, color: greyBorderColor),
          hintText: hintTitle,
          controller: controller,
        ),
      ),
    );
  }
}
