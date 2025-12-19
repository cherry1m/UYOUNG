import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class CommonIconBages extends StatelessWidget {
  final double left;
  final double top;
  final String imagePath;
  final String title;
  final double imageSize;
  final VoidCallback? onTap;

  const CommonIconBages({
    super.key,
    required this.left,
    required this.top,
    required this.imagePath,
    required this.title,
    this.imageSize = 42,
    // required int? width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent, // 🔥 중요 (터치 영역 확보)
        onTap: onTap, // 🔥 이게 빠져 있었음
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // MARK: 흰색 원 + 이미지
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Image.asset(imagePath, width: imageSize),
              ],
            ),

            // MARK: 아래 파란 라벨
            Positioned(
              bottom: -10,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: title.length <= 2 ? 10 : 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7EA9F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: AppFontStyle.S9.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
