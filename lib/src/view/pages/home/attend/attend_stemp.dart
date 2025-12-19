import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendStempPage extends StatelessWidget {
  const AttendStempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/checkstep2.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: Expanded(
                child: _bottomButton(
                  text: "아이템 확인해 보기",
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
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
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF6EA8EB),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(text, style: AppFontStyle.H6.copyWith(color: Colors.white)),
      ),
    );
  }
}
