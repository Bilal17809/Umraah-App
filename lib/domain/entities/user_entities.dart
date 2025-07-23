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

  UserEntity({
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
}
