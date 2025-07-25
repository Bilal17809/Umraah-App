import 'package:shared_preferences/shared_preferences.dart';
import 'package:umraah_app/data/model/login_model.dart';
import 'package:umraah_app/data/model/registration_model.dart';
import 'package:umraah_app/data/model/verifyopt_model.dart';
import '../../core/network/api_response.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/network_data_sr.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult> register(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    return await remoteDataSource.registerUser(model);
  }

  @override
  Future<ApiResult> otpVerify(OtpEntity user) async {
    final otpModel = OtpVerifyModel.fromEntity(user);
    return await remoteDataSource.verifyOtp(otpModel);
  }

  @override
  Future<ApiResult> login(LoginEntity login) async {
    final loginModel = LoginModel.fromEntity(login);
    final result = await remoteDataSource.loginUser(loginModel);
    if (result.success && result.data != null) {
      final token = result.data;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }
    return result;
  }


  @override
  Future<ApiResult> profile() async {
    final token = await getTokenFromStorage();
    if (token == null) {
      return ApiResult(success: false, message: "Token not found");
    }
    return await remoteDataSource.profile(token);
  }
}


Future<String?> getTokenFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
