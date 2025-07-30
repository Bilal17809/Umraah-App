import '/domain/entities/user_entities.dart';

class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginModel.fromEntity(LoginEntity user) {
    return LoginModel(
      email: user.email ?? '',
      password: user.password ?? '',
    );
  }
}
