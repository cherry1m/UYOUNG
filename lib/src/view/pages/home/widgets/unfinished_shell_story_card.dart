import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class UnfinishedShellStoryCard extends StatelessWidget {
  final String imagePath;
  final String tag;
  final VoidCallback? onTap;

  const UnfinishedShellStoryCard({
    super.key,
    required this.imagePath,
    required this.tag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25),
                BlendMode.darken,
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 공통 프레임
          Positioned.fill(
            child: IgnorePointer(
              child: Image.asset(
                "assets/images/unfinished_seacontent_frame.png",
                fit: BoxFit.fill,
              ),
            ),
          ),

          /// 팸 이름
          Positioned(
            top: 19,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  tag,
                  style: AppFontStyle.H9.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

          /// 중앙 텍스트
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "최근 우리가 제일 웃겼던\n순간은 언제였을까?",
                  textAlign: TextAlign.center,
                  style: AppFontStyle.F4.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
