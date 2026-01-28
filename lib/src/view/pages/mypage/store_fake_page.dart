import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';

class StoreFakePage extends StatelessWidget {
  const StoreFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // iOS 드래그 느낌
          child: Stack(
            children: [
              Image.asset(
                'assets/images/store_page.png',
                width: width, // 화면 너비 꽉
                fit: BoxFit.fitWidth, // 비율 유지
              ),
              // ✅ 뒤로가기 버튼 영역
              Positioned(
                top: 8,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // ✅ 이전 화면으로 돌아가기
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    color: Colors.transparent,
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
