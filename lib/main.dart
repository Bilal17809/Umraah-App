import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/domain/repositories/repositories.dart';
import 'package:umraah_app/domain/use-cases/create_packages.dart';
import 'package:umraah_app/domain/use-cases/forgot_password_case.dart';
import 'package:umraah_app/domain/use-cases/my_packages.dart';
import 'package:umraah_app/domain/use-cases/reset_password.dart';
import 'package:umraah_app/domain/use-cases/update_profile.dart';
import 'package:umraah_app/presentation/create_packages/bloc/create_package_cubit.dart';
import 'package:umraah_app/presentation/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:umraah_app/presentation/my_packages/bloc/my_package_cubit.dart';
import 'package:umraah_app/presentation/reset_password/bloc/reset_password_cubit.dart';
import 'package:umraah_app/presentation/update_package/bloc/update_package_cubit.dart';
import 'package:umraah_app/presentation/update_profile/bloc/update_profile_cubit.dart';
import '/domain/use-cases/login_case.dart';
import '/domain/use-cases/otp_case.dart';
import '/domain/use-cases/profile_case.dart';
import '/domain/use-cases/signup_case.dart';
import '/presentation/login/bloc/login_cubit.dart';
import '/presentation/profile/bloc/profile_cubit.dart';
import '/presentation/signup/bloc/signup_cubit.dart';
import '/presentation/verify_otp/bloc/verify_otp_cubit.dart';
import 'core/network/api_client.dart';
import 'core/route/route.dart';
import 'core/route/route_name.dart';
import 'data/data_source/network_data_sr.dart';
import 'data/repositories_impl/repositories_impl.dart';
import 'domain/use-cases/delete_package_case.dart';
import 'domain/use-cases/update_package.dart';


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import '../../../core/util/loader_dialog.dart';
import '../../../core/util/toast_message.dart';
import '/domain/entities/create_package_entity.dart';
import 'package:http/http.dart' as http;


void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  final remoteDataSource = AuthRemoteDataSource(apiClient);
  final userRepository = UserRepositoryImpl(remoteDataSource);
  final registerUseCase = SignupUseCase(userRepository);
  final otpUseCase = OtpVerifyUseCase(userRepository);
  final loginUseCase= LoginUseCase(userRepository);
  final profileCase= ProfileUseCase(userRepository);
  final updateProfileCase= UpdateProfileCase(userRepository);
  final createPackages = CreatePackages(userRepository);
  final myPackage = MyPackagesUseCase(userRepository);
  final forgotPassword = ForgotPasswordUseCase(userRepository);
  final resetPassword = ResetPasswordCase(userRepository);
  final updatePackage = UpdatePackageCase(userRepository);
  final deletePackages = DeletePackageCase(userRepository);

  runApp(MyApp(
    registerUseCase: registerUseCase,
    otpUseCase: otpUseCase,
    loginUseCase: loginUseCase,
    profileCase: profileCase,
    createPackages: createPackages,
    myPackages: myPackage,
    updateProfileCase: updateProfileCase,
    forgotPasswordUseCase: forgotPassword,
    resetPasswordCase: resetPassword,
    updatePackageCase: updatePackage,
    deletePackageCase: deletePackages,
  ));
}

class MyApp extends StatelessWidget {
  final SignupUseCase registerUseCase;
  final OtpVerifyUseCase otpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileCase;
  final CreatePackages createPackages;
  final MyPackagesUseCase  myPackages;
  final UpdateProfileCase updateProfileCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordCase resetPasswordCase;
  final UpdatePackageCase updatePackageCase;
  final DeletePackageCase deletePackageCase;

  const MyApp({
    super.key,
    required this.registerUseCase,
    required this.otpUseCase,
    required this.loginUseCase,
    required this.profileCase,
    required this.createPackages,
    required this.myPackages,
    required this.updateProfileCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordCase,
    required this.updatePackageCase,
    required this.deletePackageCase

  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignupCubit(registerUseCase),
        ),
        BlocProvider(
          create: (_) => OtpVerifyCubit(otpUseCase),
        ),
        BlocProvider(
          create: (_) => LoginCubit(loginUseCase),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(profileCase),
        ),
        BlocProvider(
          create: (_) => CreatePackageCubit(createPackages),
        ),
        BlocProvider(
          create: (_) => MyPackageCubit(myPackages,deletePackageCase),
        ),
        BlocProvider(
          create: (_) => UpdateProfileCubit(updateProfileCase),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(forgotPasswordUseCase),
        ),
        BlocProvider(
          create: (_) => ResetPasswordCubit(resetPasswordCase),
        ),
        BlocProvider(
          create: (_) => UpdatePackageCubit(updatePackageCase),
        ),
        BlocProvider(
          create: (_) => UpdatePackageCubit(updatePackageCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UploadScreen(),
        // initialRoute: RoutesName.splash,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcHNvbGFjZS5jb20vdW1yYWhBcGkvIiwiYXVkIjoicHJvZHVjdGlvbl9hcGkiLCJpYXQiOjE3NTQ0MTEwMTUsImV4cCI6MTc1NDQ5NzQxNSwidXNlciI6eyJpZCI6IjUyIiwiZW1haWwiOiJiaWxhbGtod2FyMkBnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJiaWxhbCIsImxhc3ROYW1lIjoidWxoYXEiLCJwaG9uZU51bWJlciI6IjA5OTg4NTgiLCJ1c2VySW1hZ2UiOiIiLCJhZ2VuY3lJbWFnZSI6IiIsImNyZWF0ZWRBdCI6IjIwMjUtMDgtMDMgMjI6MzM6MDkiLCJ1c2VyVHlwZSI6IkFHRU5UIn19.4uJnzMf-PbIDzWJdEV5ScWYNoAKn9aIb3YvaPJ_svtw";


class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _image;

  String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcHNvbGFjZS5jb20vdW1yYWhBcGkvIiwiYXVkIjoicHJvZHVjdGlvbl9hcGkiLCJpYXQiOjE3NTQ0MTEwMTUsImV4cCI6MTc1NDQ5NzQxNSwidXNlciI6eyJpZCI6IjUyIiwiZW1haWwiOiJiaWxhbGtod2FyMkBnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJiaWxhbCIsImxhc3ROYW1lIjoidWxoYXEiLCJwaG9uZU51bWJlciI6IjA5OTg4NTgiLCJ1c2VySW1hZ2UiOiIiLCJhZ2VuY3lJbWFnZSI6IiIsImNyZWF0ZWRBdCI6IjIwMjUtMDgtMDMgMjI6MzM6MDkiLCJ1c2VyVHlwZSI6IkFHRU5UIn19.4uJnzMf-PbIDzWJdEV5ScWYNoAKn9aIb3YvaPJ_svtw";


  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> uploadTestImage(File imageFile) async {
    final uri = Uri.parse("https://appsolace.com/umrahApi/public/api/createPackage");

    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // 🔁 Include ALL required fields
    request.fields['title'] = 'Test Package';
    request.fields['price'] = '5000';
    request.fields['agencyId'] = '123';
    request.fields['noOfDays'] = '10';

    final mimeTypeData = lookupMimeType(imageFile.path)?.split('/') ?? ['image', 'jpeg'];

    final image = await http.MultipartFile.fromPath(
      'packageImage',
      imageFile.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );

    request.files.add(image);

    print("Sending request...");

    try {
      final response = await request.send();
      final resBody = await response.stream.bytesToString();
      print("Status Code: ${response.statusCode}");
      print("Response Body: $resBody");

      if (response.statusCode == 200) {
        print("✅ Upload success!");
      } else {
        print("❌ Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception during upload: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Umrah Package")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_image != null)
              Image.file(File(_image!.path), height: 150),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  uploadTestImage(File(_image!.path));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pick an image first')));
                }
              },
              child: Text("Upload Package"),
            ),
          ],
        ),
      ),
    );
  }
}

