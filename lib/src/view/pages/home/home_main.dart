import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/home/common_icon_bages.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

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
          _pearlBox(),
          _alert(),
          _pearlContent(),
          _shop(),
          _check(),
          _bottomStoryCard(context),
        ],
      ),
    );
  }

  // MARK: - 하단 조개 이야기 카드
  Widget _bottomStoryCard(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 19,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/home_alert_background.png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "완성되지 않은 조개 이야기!\n이어가면 진주가 생길지도…?",
                      style: AppFontStyle.M_18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShellStoryPage(),
                        ),
                      );
                    },
                    child: Text(
                      "이어서 진행하기 >",
                      style: AppFontStyle.M_14.copyWith(
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - 상단 진주 박스, 알림 아이콘
  Widget _pearlBox() {
    return Positioned(
      top: 60,
      left: 20,
      child: Image(
        image: AssetImage("assets/images/pearl_box.png"),
        width: 82,
        height: 36,
      ),
    );
  }

  // MARK: - 조개 이야기 아이콘
  Widget _pearlContent() {
    return CommonIconBages(
      left: 20,
      top: 106,
      imagePath: "assets/images/shell_content.png",
      imageSize: 60,
      title: "조개 이야기",
      width: 1,
    );
  }

  //MARK: - 상단 알림 아이콘
  Widget _alert() {
    return Positioned(
      top: 60,
      right: 15,
      child: Image(
        image: AssetImage("assets/images/alert.png"),
        width: 28,
        height: 30,
      ),
    );
  }

  // MARK: - 상점 아이콘
  Widget _shop() {
    return CommonIconBages(
      left: 330,
      top: 106,
      imagePath: "assets/images/store.png",
      imageSize: 60,
      title: "상점",
      width: 1,
    );
  }

  // MARK: - 출석 체크 아이콘
  Widget _check() {
    return CommonIconBages(
      left: 335,
      top: 186,
      imagePath: "assets/images/pearl_shell.png",
      imageSize: 35,
      title: "출석 체크",
      width: 1,
    );
  }
}
