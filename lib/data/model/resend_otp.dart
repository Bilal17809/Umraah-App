import '/domain/entities/resend_otp_entity.dart';

class ResendOtp {
  final String email;

  ResendOtp({required this.email});

  Map<String, dynamic> toJson() => {
    'email': email,
  };

  factory ResendOtp.fromEntity(ResendOtpEntity entity) {
    return ResendOtp(email: entity.email);
  }
}
