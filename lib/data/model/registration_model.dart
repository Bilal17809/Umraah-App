import '../../domain/entities/user_entities.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String agencyName;
  final String agencyAddress;
  final String agencyLicenceNumber;
  final String userImageBase64;
  final String userType;
  final String agencyImageBase64;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyLicenceNumber,
    required this.userImageBase64,
    required this.userType,
    required this.agencyImageBase64,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "agencyName": agencyName,
    "agencyAddress": agencyAddress,
    "agencyLicenceNumber": agencyLicenceNumber,
    "userImage": userImageBase64,
    "userType": userType,
    "agencyImage": agencyImageBase64,
  };

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      agencyName: entity.agencyName,
      agencyAddress: entity.agencyAddress,
      agencyLicenceNumber: entity.agencyLicenceNumber,
      userImageBase64: entity.userImageBase64,
      userType: entity.userType,
      agencyImageBase64: entity.agencyImageBase64,
    );
  }
}
