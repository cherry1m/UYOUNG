import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class MemoryBottomSheet extends StatelessWidget {
  final DateTime date;
  // 나중에 기억섬 목록, 선택된 섬 등도 여기로 넘기면 됨

  const MemoryBottomSheet({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          // ⭐ box-shadow 적용 + 흰 배경 + 위쪽만 radius
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000), // #00000014
                offset: Offset(0, -4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // 상단 그립바
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),

              // 날짜 타이틀
              Text("${date.month}월 ${date.day}일", style: AppFontStyle.M_20),

              const SizedBox(height: 12),

              // 컨텐츠 영역
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  children: [
                    Text(
                      '이 날짜에 대한 기억섬 데이터를 여기서 보여줄 예정이에요.',
                      style: AppFontStyle.M_16.copyWith(
                        color: AppColors.mainGray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // TODO: 여기부터 실제 카드, 썸네일 리스트, 태그 등 넣으면 됨
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
