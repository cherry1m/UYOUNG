import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          /// 🔹 상단 여백
          const Spacer(flex: 2),

          /// ───── 중앙 콘텐츠 (해달 + 텍스트)
          Column(
            children: [
              Image.asset(
                "assets/images/comment_seaotter.png",
                width: 150,
                height: 170,
              ),
              const SizedBox(height: 24),
              Text("아직 댓글이 없어요!", style: AppFontStyle.F3),
              const SizedBox(height: 6),
              Text(
                "첫번째 댓글을 남겨보세요.",
                style: AppFontStyle.S7.copyWith(color: const Color(0xFF666666)),
              ),
            ],
          ),

          /// 🔹 중앙 유지용 Spacer
          const Spacer(flex: 3),

          /// ───── 하단 댓글 입력 영역 (살짝 위)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                /// 프로필
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/lee_profile.png"),
                ),
                const SizedBox(width: 8),

                /// 입력 필드
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE3E3E3),
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "느끼는 감정을 적어 주세요!",
                        hintStyle: AppFontStyle.S8.copyWith(
                          color: const Color(0xFFAAAAAA),
                        ),
                        border: InputBorder.none,
                      ),
                      style: AppFontStyle.S8,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                /// 전송 버튼
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF2FF),
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: Color(0xFF4880ED),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
