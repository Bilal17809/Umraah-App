import '/domain/entities/user_entities.dart';

class OtpVerifyModel {
  final String email;
  final String otp;

  OtpVerifyModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  factory OtpVerifyModel.fromEntity(OtpEntity user) {
    return OtpVerifyModel(
      email: user.email ?? '',
      otp: user.otp ?? '',
    );
  }
}
