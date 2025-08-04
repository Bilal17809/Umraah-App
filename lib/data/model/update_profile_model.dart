import '../../domain/entities/update_user_profile.dart';

class UpdateProfileModel extends UpdateUserProfileEntity {
  UpdateProfileModel({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String agencyImage,
    required String userImage,
    required String agencyName,
    required String agencyAddress,
    required String agencyLicenceNumber,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    agencyImage: agencyImage,
    userImage: userImage,
    agencyName: agencyName,
    agencyAddress: agencyAddress,
    agencyLicenceNumber: agencyLicenceNumber,
  );

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      agencyImage: json['agencyImage'] ?? '',
      userImage: json['userImage'] ?? '',
      agencyName: json['agencyName'] ?? '',
      agencyAddress: json['agencyAddress'] ?? '',
      agencyLicenceNumber: json['agencyLicenceNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'agencyImage': agencyImage,
      'userImage': userImage,
      'agencyName': agencyName,
      'agencyAddress': agencyAddress,
      'agencyLicenceNumber': agencyLicenceNumber,
    };
  }

  /// ✅ Convert from entity to model
  factory UpdateProfileModel.fromEntity(UpdateUserProfileEntity entity) {
    return UpdateProfileModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      agencyImage: entity.agencyImage,
      userImage: entity.userImage,
      agencyName: entity.agencyName,
      agencyAddress: entity.agencyAddress,
      agencyLicenceNumber: entity.agencyLicenceNumber,
    );
  }
}
