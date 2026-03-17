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
  static String get checkBlack => 'assets/images/check_black.png';
  static String get checkedBlack => 'assets/images/checked_black.png';
  static String get trash => 'assets/images/trash.png';

  // 바다노트(다이어리)
  static String get diaryOn => 'assets/images/diary_on.png';
  static String get diaryOff => 'assets/images/diary.png';

  // 상점
  static String get storeOn => 'assets/images/store_on.png';
  static String get storeOff => 'assets/images/store_off.png';

  // 마이페이지
  static String get myPageOn => 'assets/images/my_page_on.png';
  static String get myPageOff => 'assets/images/my_page.png';
  static String get myPageMain => 'assets/images/my_page_main.png';
  static String get myProfile => 'assets/images/my_profile.png';
  static String get mypageOtter => 'assets/images/mypage/otter.png';
  static String get mypagePearl => 'assets/images/mypage/pearl.png';
  static String get mypageNoticeSheet => 'assets/images/mypage/notice.png';
  static String get notice => 'assets/images/notice.png';
  static String get friendList => 'assets/images/friend_list.png';
  static String get friendListButton => 'assets/images/friend_list_button.png';
  static String get friendProfile => 'assets/images/friend_profile.png';
  static String get choProfile => 'assets/images/cho_profile.png';
  static String get yoonProfile => 'assets/images/yoon_profile.png';
  static String get inviteFriend => 'assets/images/invite_friend.png';
  static String get inviteBg => 'assets/images/invite_bg.png';
  static String get storePage => 'assets/images/store_page.png';
  static String get pearl => 'assets/images/pearl.png';
  static String get pearl10 => 'assets/images/pearl_10.png';
  static String get pearl50 => 'assets/images/pearl_50.png';
  static String get pearl100 => 'assets/images/pearl_100.png';
  static String get pearl200 => 'assets/images/pearl_200.png';
  static String get pearl300 => 'assets/images/pearl_300.png';
  static String get pearlBasket => 'assets/images/pearl_basket.png';
  static String get pearlShell => 'assets/images/pearl_shell.png';
  static String get pearlBox => 'assets/images/pearl_box.png';
  static String get pearls => 'assets/images/pearls.png';
}
