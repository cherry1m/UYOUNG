import 'package:flutter/material.dart';

class ImageData extends StatelessWidget {
  final String path;
  final double width;
  final double height;

  const ImageData({
    super.key,
    required this.path,
    this.width = 60,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: width, height: height);
  }
}

class ImagePath {
  // MARK: - Bottom nav icons

  // 홈
  static String get homeOn => 'assets/images/home_on.png';
  static String get homeOff => 'assets/images/home.png';

  // 기억섬(방)
  static String get roomOn => 'assets/images/room_on.png';
  static String get roomOff => 'assets/images/room.png';

  // 캘린더
  static String get calendarOn => 'assets/images/calendar_on.png';
  static String get calendarOff => 'assets/images/calendar.png';
  static String get dayBox => 'assets/images/calendar_icon.png';
  static String get filter => 'assets/images/filter.png';
  static String get today => 'assets/images/today.png';
  static String get setting => 'assets/images/setting.png';
  static String get sortUpDown => 'assets/images/sort_up_down.png';
  static String get chevronRight => 'assets/images/chevron_right.png';
  static String get hamburgerBar => 'assets/images/hamburger_bar.png';

  // 바다노트(다이어리)
  static String get diaryOn => 'assets/images/diary_on.png';
  static String get diaryOff => 'assets/images/diary.png';

  // 마이페이지
  static String get myPageOn => 'assets/images/my_page_on.png';
  static String get myPageOff => 'assets/images/my_page.png';
}
