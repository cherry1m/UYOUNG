import 'package:uyoung/data/model/home/attend_check_model.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day1_page.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day2_page.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day3_page.dart';

final List<AttendDayItem> attendDays = [
  AttendDayItem(
    day: 1,
    iconPath: "assets/images/pearl.png",
    page: const AttendDay1Page(),
    isActive: true,
  ),
  AttendDayItem(
    day: 2,
    iconPath: "assets/images/trash3.png",
    page: const AttendDay2Page(),
    isActive: true,
  ),
  AttendDayItem(
    day: 3,
    iconPath: "assets/images/question.png",
    page: const AttendDay3Page(),
    isActive: true,
  ),
  AttendDayItem(
    day: 4,
    iconPath: "assets/images/question.png",

    page: null,
    isActive: false,
  ),
  AttendDayItem(
    day: 5,
    iconPath: "assets/images/question.png",

    page: null,
    isActive: false,
  ),
  AttendDayItem(
    day: 6,
    iconPath: "assets/images/question.png",

    page: null,
    isActive: false,
  ),
  AttendDayItem(
    day: 7,
    iconPath: "assets/images/pearls.png",

    page: null,
    isActive: false,
  ),
];
