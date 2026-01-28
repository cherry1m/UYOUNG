import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/mypage/friend_list_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/store_fake_page.dart';

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
                    width: 75,
                    height: 90, // 친구목록 영역 높이
                    color: Colors.transparent, // 👈 절대 지우지 마
                  ),
                ),
              ),

              // ✅ 상점 클릭 영역 (조개이야기 옆)
              Positioned(
                top: 450, // ❗️조개이야기 옆 위치에 맞게 조절
                left: 210, // 오른쪽 영역
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StoreFakePage()),
                    );
                  },
                  child: Container(
                    width: 75,
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
