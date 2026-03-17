import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/image_data.dart';

class StoreFakePage extends StatelessWidget {
  const StoreFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true, // 🔥 상단까지 확장
      body: Stack(
        children: [
          // ✅ 전체 화면 이미지
          Image.asset(
            ImagePath.storePage,
            width: width,
            fit: BoxFit.fitWidth,
          ),

          // ✅ 뒤로가기 버튼 영역
          Positioned(
            top: 8, // 필요하면 0으로도 가능
            left: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 56,
                height: 56,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
