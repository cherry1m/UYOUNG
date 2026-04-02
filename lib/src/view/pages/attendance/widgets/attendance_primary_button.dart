import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendancePrimaryButton extends StatelessWidget {
  const AttendancePrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color(0xFF6EA8EB),
    this.textColor = Colors.white,
    this.height = 56,
    this.borderRadius = 16,
  });

  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          text,
          style: AppFontStyle.H6.copyWith(color: textColor),
        ),
      ),
    );
  }
}
