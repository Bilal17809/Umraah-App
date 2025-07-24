import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';

class FiltersView extends StatelessWidget {
  const FiltersView({super.key});

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filters",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: hiegt * 0.34,
              width: double.infinity,
              decoration: roundedDecoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    _reusableRow(title: "Dates"),
                    Divider(height: 50),
                    _reusableRow(title: "Duration"),
                    Divider(height: 50),
                    _reusableRow(title: "Price Range"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 26),
            Row(
              children: [
                ElevatedButtons(
                  buttonTitle: "Reset",
                  onTap: () {},
                  isOutlined: true,
                ),
                SizedBox(width: 20),
                ElevatedButtons(
                  buttonTitle: "Apply Filters",
                  onTap: () {},
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _reusableRow extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _reusableRow({super.key, required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: Icon(Icons.arrow_forward_ios, size: 20)),
      ],
    );
  }
}

class ElevatedButtons extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback? onTap;
  final Color? color;
  final bool isOutlined;
  const ElevatedButtons({
    super.key,
    required this.buttonTitle,
    this.onTap,
    this.color,
    this.isOutlined = false, 
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 62,
        child: ElevatedButton(
          style: AppTheme.elevatedButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(
              isOutlined
                  ? Colors.transparent
                  : color ?? Theme.of(context).primaryColor,
            ),
            foregroundColor: MaterialStateProperty.all(
              isOutlined ? Colors.black : Colors.white,
            ),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side:
                    isOutlined
                        ? const BorderSide(color: Colors.black, width: 2)
                        : BorderSide.none,
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(buttonTitle, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
