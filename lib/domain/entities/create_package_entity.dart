import 'dart:io';

class CreatePackageEntity {
  final int noOfDays;
  final String startDate;
  final String makkahHotelName;
  final String makkahHotelDistance;
  final double makkahHotelRating;
  final String madinaHotelName;
  final String madinaHotelDistance;
  final double madinaHotelRating;
  final String detail;
  final String flightNumber;
  final String airLine;
  final String packageImage;
  final String packageSharedPrice;
  final String packageTriplePrice;
  final String packageDoublePrice;
  final String packageInclude;
  final String packId;
  final int? status;


  const CreatePackageEntity({
    required this.noOfDays,
    required this.startDate,
    required this.makkahHotelName,
    required this.makkahHotelDistance,
    required this.makkahHotelRating,
    required this.madinaHotelName,
    required this.madinaHotelDistance,
    required this.madinaHotelRating,
    required this.detail,
    required this.flightNumber,
    required this.airLine,
    required this.packageImage,
    required this.packageSharedPrice,
    required this.packageTriplePrice,
    required this.packageDoublePrice,
    required this.packageInclude,
    required this.packId,
    this.status,
  });
}
