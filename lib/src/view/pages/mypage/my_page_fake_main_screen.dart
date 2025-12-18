import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/mypage/friend_list_fake_page.dart';

class MyPageFakeScreen extends StatelessWidget {
  const MyPageFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              // ✅ 전체 마이페이지 이미지
              Image.asset(
                'assets/images/my_page_main.png',
                width: w,
                fit: BoxFit.fitWidth,
              ),

              // ✅ 친구목록 클릭 영역 (투명 버튼)
              Positioned(
                top: 450, // ❗️여기 수치는 이미지 보고 맞춰야 함
                left: 18,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendListFakePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: w - 36,
                    height: 90, // 친구목록 영역 높이
                    color: Colors.transparent, // 👈 절대 지우지 마
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
