import 'package:flutter/material.dart';

class AttendanceStageLayout extends StatelessWidget {
  const AttendanceStageLayout({
    super.key,
    required this.top,
    required this.safeBottom,
    required this.backgroundAssetPath,
    required this.object,
    required this.text,
    required this.action,
    this.objectHorizontalPadding = 28,
    this.textHorizontalPadding = 28,
    this.textTopSpacing = 16,
    this.actionHorizontalPadding = 16,
  });

  final double top;
  final double safeBottom;
  final String backgroundAssetPath;
  final Widget object;
  final Widget text;
  final Widget action;
  final double objectHorizontalPadding;
  final double textHorizontalPadding;
  final double textTopSpacing;
  final double actionHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            backgroundAssetPath,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: objectHorizontalPadding,
          right: objectHorizontalPadding,
          top: top,
          child: object,
        ),
        Positioned(
          left: textHorizontalPadding,
          right: textHorizontalPadding,
          top: top + textTopSpacing,
          child: text,
        ),
        Positioned(
          left: actionHorizontalPadding,
          right: actionHorizontalPadding,
          bottom: safeBottom + 2,
          child: action,
        ),
      ],
    );
  }
}
