class UpdateUserProfileEntity {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String agencyImage;
  final String userImage;
  final String agencyName;
  final String agencyAddress;
  final String agencyLicenceNumber;

  UpdateUserProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.agencyImage,
    required this.userImage,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyLicenceNumber,
  });
}
