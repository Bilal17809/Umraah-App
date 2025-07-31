import '../../domain/entities/create_package_entity.dart';

class CreatePackageModel {
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

  const CreatePackageModel({
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
  });

  factory CreatePackageModel.fromJson(Map<String, dynamic> json) {
    return CreatePackageModel(
      noOfDays: json['noOfDays'] ?? 0,
      startDate: json['startDate'] ?? '',
      makkahHotelName: json['makkahHotelName'] ?? '',
      makkahHotelDistance: json['makkahHotelDistance'] ?? '',
      makkahHotelRating: (json['makkahHotelRating'] ?? 0).toDouble(),
      madinaHotelName: json['madinaHotelName'] ?? '',
      madinaHotelDistance: json['madinaHotelDistance'] ?? '',
      madinaHotelRating: (json['madinaHotelRating'] ?? 0).toDouble(),
      detail: json['detail'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      airLine: json['airLine'] ?? '',
      packageImage: json['packageImage'] ?? '',
      packageSharedPrice: json['packageSharedPrice'] ?? '',
      packageTriplePrice: json['packageTriplePrice'] ?? '',
      packageDoublePrice: json['packageDoublePrice'] ?? '',
      packageInclude: json['packageInclude'] ?? '',
    );
  }

  factory CreatePackageModel.fromEntity(CreatePackageEntity entity) {
    return CreatePackageModel(
      noOfDays: entity.noOfDays,
      startDate: entity.startDate,
      makkahHotelName: entity.makkahHotelName,
      makkahHotelDistance: entity.makkahHotelDistance,
      makkahHotelRating: entity.makkahHotelRating,
      madinaHotelName: entity.madinaHotelName,
      madinaHotelDistance: entity.madinaHotelDistance,
      madinaHotelRating: entity.madinaHotelRating,
      detail: entity.detail,
      flightNumber: entity.flightNumber,
      airLine: entity.airLine,
      packageImage: entity.packageImage,
      packageSharedPrice: entity.packageSharedPrice,
      packageTriplePrice: entity.packageTriplePrice,
      packageDoublePrice: entity.packageDoublePrice,
      packageInclude: entity.packageInclude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "noOfDays": noOfDays,
      "startDate": startDate,
      "makkahHotelName": makkahHotelName,
      "makkahHotelDistance": makkahHotelDistance,
      "makkahHotelRating": makkahHotelRating,
      "madinaHotelName": madinaHotelName,
      "madinaHotelDistance": madinaHotelDistance,
      "madinaHotelRating": madinaHotelRating,
      "detail": detail,
      "flightNumber": flightNumber,
      "airLine": airLine,
      "packageImage": packageImage,
      "packageSharedPrice": packageSharedPrice,
      "packageTriplePrice": packageTriplePrice,
      "packageDoublePrice": packageDoublePrice,
      "packageInclude": packageInclude,
    };
  }
}
