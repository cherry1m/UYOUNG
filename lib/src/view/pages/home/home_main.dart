import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/common/home/common_icon_bages.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_stemp.dart';
import 'package:uyoung/src/view/pages/home/attend_check_page.dart';
import 'package:uyoung/src/view/pages/home/notification_page.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  static const String _defaultPearlCountLabel = '128개';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/home_main.png",
              fit: BoxFit.cover,
              alignment: const Alignment(0, -1.0),
            ),
          ),
          Positioned(
            left: 90,
            top: 342,
            child: Image.asset(
              ImagePath.homeMyCharacter,
              width: 211,
              height: 224,
              fit: BoxFit.contain,
            ),
          ),
          _pearlBox(context),
          _alert(context),
          _check(),
        ],
      ),
    );
  }

  // MARK: - 상단 진주 박스, 알림 아이콘
  Widget _pearlBox(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AttendCheckPage()),
          );
        },
        child: SizedBox(
          width: 82,
          height: 36,
          child: Stack(
            children: [
              const Image(
                image: AssetImage("assets/images/pearl_box.png"),
                width: 82,
                height: 36,
              ),
              Positioned(
                top: 12,
                left: 39,
                child: Text(
                  // TODO(seongeunii): Replace with the user's live pearl count.
                  _defaultPearlCountLabel,
                  style: AppFontStyle.H8.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //MARK: - 상단 알림 아이콘
  Widget _alert(BuildContext context) {
    return Positioned(
      top: 60,
      right: 15,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationPage()),
          );
        },
        child: const Image(
          image: AssetImage("assets/images/alert.png"),
          width: 28,
          height: 30,
        ),
      ),
    );
  }

  // MARK: - 출석 체크 아이콘
  Widget _check() {
    return Builder(
      builder: (context) {
        return CommonIconBages(
          left: 20,
          top: 106,
          imagePath: "assets/images/pearl_shell.png",
          imageSize: 35,
          title: "출석 체크",

          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AttendStempPage()),
          ),
        );
      },
    );
  }
}
