import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendDay1Page extends StatelessWidget {
  const AttendDay1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 배경
          Positioned.fill(
            child: Image.asset(
              "assets/images/pearl_check.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 하단 버튼 영역
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: _bottomButton(
                      text: "출석 확인하기",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _bottomButton(
                      text: "홈으로 가기",
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
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

  /// 하단 공통 버튼
  Widget _bottomButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppFontStyle.H6.copyWith(color: const Color(0xFF6EA8EB)),
        ),
      ),
    );
  }
}
