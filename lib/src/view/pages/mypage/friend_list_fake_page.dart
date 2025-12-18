import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/mypage/my_page_fake_main_screen.dart';
import 'friend_profile_fake_page.dart';

class FriendListFakePage extends StatelessWidget {
  const FriendListFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              // ✅ 전체 친구목록 이미지
              Image.asset(
                'assets/images/friend_list.png',
                width: width,
                fit: BoxFit.fitWidth,
              ),

              // ✅ 뒤로가기 버튼 영역
              Positioned(
                top: 8,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyPageFakeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    color: Colors.transparent,
                  ),
                ),
              ),

              // ✅ 첫 번째 친구 프로필 터치 영역
              Positioned(
                top: 150, // ❗️사진 기준으로 맞춘 값 (필요시 미세조정)
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendProfileFakePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: width,
                    height: 80,
                    color: Colors.transparent,
                  ),
                ),
              ),

              // 👉 나중에 필요하면 이런 식으로 계속 추가 가능
              /*
              Positioned(
                top: 230,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendProfileFakePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: width,
                    height: 80,
                    color: Colors.transparent,
                  ),
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}
