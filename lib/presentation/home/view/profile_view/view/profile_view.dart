import 'dart:io';

import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView2 extends StatefulWidget {
 ProfileView2({super.key});

  @override
  State<ProfileView2> createState() => _ProfileView2State();
}

class _ProfileView2State extends State<ProfileView2> {

File? _profileImage;

Future<void> pickImageFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                height: hiegt * 0.24,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.14),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            
SizedBox(height: hiegt * 0.10),



Flexible( 
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _profileRow(
            title: "Izhar",
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            icon: Icons.edit,
            tapOnEdite: () {},
          ),
          SizedBox(height: hiegt * 0.03),
          _profileRow(
            title: "Badshah",
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            icon: Icons.edit,
            tapOnEdite: () {},
          ),
          SizedBox(height: hiegt * 0.03),
          _profileRow(
            title: "Izharbadshah1122@gmail.com",
            textStyle: TextStyle(fontSize: 14),
            icon: Icons.edit,
            tapOnEdite: () {},
          ),
          SizedBox(height: hiegt * 0.03),
       
        ],
      ),
    ),
  ),
),


               Align(
                alignment: Alignment.bottomCenter,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                   child: ElevatedButton(
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Change"),
                    ),
                 ),
               ),
            ],
          ),

          Positioned(
            top: hiegt * 0.12,
            left: (width - (hiegt * 0.20)) / 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: hiegt * 0.20,
                  width: hiegt * 0.20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.white, width: 4.0),
                  
                    
                  ),
                child: Center(
  child: _profileImage == null
      ? Icon(Icons.person, size: 80, color: Colors.grey)
      : ClipOval(
          child: Image.file(
            _profileImage!,
             height: hiegt * 0.20,
                  width: hiegt * 0.20,
            fit: BoxFit.cover,
          ),
        ),
),
                ),
                Positioned(
                  bottom: 10,
                  left: -0,
                  right: -100,

                  child: GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _profileRow extends StatelessWidget {
  final String title;
  final IconData? icon;
  final TextStyle? textStyle;
  final VoidCallback? tapOnEdite;
  const _profileRow({
    super.key,
    required this.title,
    required this.icon,
    this.textStyle,
    this.tapOnEdite,
  });

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        height: hiegt * 0.10,
        width: double.infinity,
        decoration: roundedDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textStyle),
              GestureDetector(onTap: tapOnEdite, child: Icon(icon,color: greyBorderColor,)),
            ],
          ),
        ),
      ),
    );
  }
}
