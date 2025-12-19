import 'package:flutter/material.dart';

class AttendDayItem {
  final int day;
  final String iconPath;
  final Widget? page;
  final bool isActive;

  AttendDayItem({
    required this.day,
    required this.iconPath,
    required this.page,
    required this.isActive,
  });
}
