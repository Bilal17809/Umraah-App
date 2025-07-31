import 'package:flutter/material.dart';

import '/core/common/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';

class LoginForm extends StatelessWidget {
  final String hintTitle;
  final IconData? icon;
  final TextEditingController? controller;
  final bool isPassword;

  const LoginForm({
    super.key,
    required this.hintTitle,
    this.icon,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller?.text ?? '',
      validator: (val) =>
      val == null || val.trim().isEmpty ? 'Please enter $hintTitle' : null,
      builder: (field) {
        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: roundedDecoration.copyWith(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  color: hasError ? Colors.red : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: CustomTextFormField(
                controller: controller,
                hintText: hintTitle,
                obscureText: isPassword,
                suffixIcon: Icon(icon, color: greyBorderColor),
                onChanged: (value) {
                  field.didChange(value);
                },
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 6),
                child: Text(
                  field.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
