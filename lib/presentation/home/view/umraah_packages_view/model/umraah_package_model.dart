import 'dart:ui';

class UmrahPackageModel {
  final String imageUrl;
  final String title;
  final String agency;
  final String date;
  final String price;
  final String? tag;
  final Color? tagColor;
  final VoidCallback? onTap;

  UmrahPackageModel({
    required this.imageUrl,
    required this.title,
    required this.agency,
    required this.date,
    required this.price,
    this.tag,
    this.tagColor,
    this.onTap,
  });
}
