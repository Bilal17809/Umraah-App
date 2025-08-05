import 'package:flutter/material.dart';
import '/core/theme/app_styles.dart';

class BuildFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const BuildFormField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FormField<String>(
        validator: (val) => controller.text.trim().isEmpty ? 'Please enter $label' : null,
        builder: (field) {
          final hasError = field.hasError;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal:16,vertical:10),
                decoration: roundedDecoration.copyWith(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: (val) => field.didChange(val),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:label,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                  ),
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
