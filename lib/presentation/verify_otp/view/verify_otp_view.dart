import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/entities/resend_otp_entity.dart';
import '../../agency_dashboard/view/agency_dashboard_view.dart';
import '/core/route/route_name.dart';
import '../bloc/verify_otp_cubit.dart';
import '../bloc/verify_otp_state.dart';
import '/domain/entities/user_entities.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String email;
  final String useType;

  const OtpVerifyScreen({super.key,
    required this.email,
    required this.useType
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendCooldown = 0;
  Timer? _resendTimer;

  void startResendCooldown() {
    setState(() {
      _resendCooldown = 30;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendCooldown--;
        });
      }
    });
  }

  String get otpCode =>
      _otpControllers.map((controller) => controller.text).join();

  @override
  void initState() {
    super.initState();
    for (var controller in _otpControllers) {
      controller.clear();
    }
    startResendCooldown();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }
  bool isOtpValid() {
    return _otpControllers.every((c) => c.text.trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.pushNamed(
                  context,
                  RoutesName.loginPage,
                  arguments:widget.useType,
                );
              }
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP resent successfully')),
                );
                // Navigator.pushNamed(
                //   context,
                //   RoutesName.loginPage,
                //   arguments:'2',
                // );
              }

              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'OTP sent to ${widget.email}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text('Enter the 6 digit OTP'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                          onChanged: (value) {
                            setState(() {}); // <- Force rebuild to enable the button
                            if (value.isNotEmpty && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },

                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _resendCooldown > 0
                        ? null
                        : () {
                      final user = ResendOtpEntity(email: widget.email);
                      context.read<OtpVerifyCubit>().resendVerifyOtp(user);
                      startResendCooldown();
                    },
                    child: Text(
                      _resendCooldown > 0
                          ? 'Resend code in $_resendCooldown s'
                          : 'Resend code',
                      style: TextStyle(
                        color: _resendCooldown > 0 ? Colors.grey : Colors.blue,
                        decoration: _resendCooldown > 0
                            ? TextDecoration.none
                            : TextDecoration.underline,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      :ElevatedButton(
                    onPressed: isOtpValid() && !state.isLoading
                        ? () {
                      final user = OtpEntity(email: widget.email, otp: otpCode);
                      context.read<OtpVerifyCubit>().verifyOtp(user);
                    }
                        : null,

                    child: const Text('Verify OTP'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AgencyDashboardScreen(),
                        ),
                      );
                    },
                    child: const Text("Next"),
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
              ),
            );
          },
        ),
      ),
    );
  }
}

