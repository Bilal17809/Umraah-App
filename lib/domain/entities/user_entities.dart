// class UserEntity {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;
//   final String phoneNumber;
//   final String agencyName;
//   final String agencyAddress;
//   final String agencyLicenceNumber;
//   final String userImageBase64;
//   final String userType;
//
//   UserEntity({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.password,
//     required this.phoneNumber,
//     required this.agencyName,
//     required this.agencyAddress,
//     required this.agencyLicenceNumber,
//     required this.userImageBase64,
//     required this.userType
//   });
// }
class UserEntity {
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

  const UserEntity({
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
}

class OtpEntity {
  final String email;
  final String otp;

  OtpEntity({
    required this.email,
    required this.otp
  });
}

class LoginEntity {
  final String email;
  final String password;

  LoginEntity({
    required this.email,
    required this.password,
  });
}
