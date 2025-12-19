import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendDay3DetailPage extends StatelessWidget {
  const AttendDay3DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/trash2_check.png",
              fit: BoxFit.cover,
            ),
          ),
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
                      text: "상점으로 가기",
                      onTap: () {
                        // TODO: 상점 페이지 이동
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
