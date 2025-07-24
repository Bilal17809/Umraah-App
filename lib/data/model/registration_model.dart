import '/domain/entities/user_entities.dart';
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
    "userType": "2",
    "agencyImage": "",
    "userImage": userImageBase64,
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
    );
  }
}
