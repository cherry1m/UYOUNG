import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';
import 'package:uyoung/src/view/pages/mypage/friend_list_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/invite_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/pear_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/store_fake_page.dart';

/// ✅ 마이페이지 “이미지로 속이는” 화면 + 버튼(친구목록 / 조개이야기 / 진주 / 친구초대)
class MyPageFakeScreen extends StatelessWidget {
  const MyPageFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ✅ 상단 아이콘 버튼 영역 위치 기준값 (이미지에 맞춰 조정)
    const double buttonTop = 450;
    const double buttonHeight = 90;
    final double buttonWidth = (w - 130) / 3; // 3등분

    // ✅ 진주(보유 재화) 영역 위치 (이미지에 맞춰 조정)
    const double pearlTop = 365;
    const double pearlHeight = 58;

    // ✅ 친구 초대(리스트 row) 영역 위치 (이미지에 맞춰 조정)
    // - "초대 및 공유" 섹션의 "친구 초대" 행 전체를 터치 영역으로 잡는 값
    const double inviteTop = 650; // 필요 시 미세 조정
    const double inviteHeight = 60; // 행 높이(대략 56~64)

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                /// ✅ 배경 이미지 (마이페이지 스샷)
                Image.asset(
                  'assets/images/my_page_main.png',
                  width: w,
                  fit: BoxFit.fitWidth,
                ),

                // =========================
                // ✅ 진주(보유 재화) 영역 탭
                Positioned(
                  top: pearlTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: w - 36, // 좌우 18씩 제외한 카드 전체 폭
                    height: pearlHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PearFakePage()),
                      );
                    },
                  ),
                ),

                // =========================
                // ✅ 친구 목록 버튼
                Positioned(
                  top: buttonTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FriendListFakePage(),
                        ),
                      );
                    },
                  ),
                ),

                // ✅ 조개 이야기 버튼
                Positioned(
                  top: buttonTop,
                  left: 18 + buttonWidth,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShellStoryPage(),
                        ),
                      );
                    },
                  ),
                ),

                // ✅ 상점 클릭 영역
                Positioned(
                  top: buttonTop,
                  left: 110 + buttonWidth,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StoreFakePage(),
                        ),
                      );
                    },
                  ),
                ),

                // =========================
                // ✅ 친구 초대(row) 탭
                Positioned(
                  top: inviteTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: w - 36, // 행 전체 폭
                    height: inviteHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InviteFakePage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ 완전 투명 터치 영역
class _FakeTapArea extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;

  const _FakeTapArea({
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(width: width, height: height),
    );
  }
}
