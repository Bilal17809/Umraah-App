
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PackageController extends GetxController{
  
//   final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

//   Future<void> pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       selectedDate.value = picked;
//     }
//   }

// }