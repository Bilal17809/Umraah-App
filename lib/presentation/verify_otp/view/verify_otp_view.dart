import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umraah_app/presentation/home/view/dashboard_view/view/dashboard_view.dart';
import 'package:umraah_app/presentation/home/view/tab_bar_view/view/tab_bar_view.dart';
import '../bloc/verify_otp_cubit.dart';
import '../bloc/verify_otp_state.dart';
import '/domain/entities/user_entities.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});
  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OtpVerifyCubit, OtpVerifyState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  if (state.isLoading) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else ...[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                      value!.isEmpty ? 'Email is required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _otpController,
                      decoration: const InputDecoration(labelText: 'OTP'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                      value!.isEmpty ? 'OTP is required' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = OtpEntity(
                            email: _emailController.text.trim(),
                            otp: _otpController.text.trim(),
                          );
                          context.read<OtpVerifyCubit>().verifyOtp(user);
                        }
                      },
                      child: const Text('Verify OTP'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AgencyDashboardScreen(),
                          ),
                        );
                      },
                      child: Text("Next"),
                    ),
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (state.isSuccess)
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'OTP Verified Successfully!',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
