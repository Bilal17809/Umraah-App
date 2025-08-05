import 'package:flutter/material.dart';

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          height: 88,
          width: 88,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.green.shade400,),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void showLoaderDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoaderDialog(message: message),
    );
  }

  void hideLoaderDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

}
