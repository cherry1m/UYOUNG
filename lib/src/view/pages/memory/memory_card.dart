import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class MemoryCard extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final bool isNotificationOn;
  final String? imagePath;

  // 사용자가 이름을 수정 중인지 여부
  final bool isEditing;

  // 수정 중일 때 사용하는 TextField의 컨트롤러
  final TextEditingController? controller;

  // 수정 완료(엔터 입력 시) 실행되는 콜백
  final VoidCallback onEditComplete;

  // 카드 클릭 시 동작 (기억섬 상세 페이지 이동)
  final VoidCallback onTap;

  // 카드 롱프레스 시 동작 (모달 열기)
  final VoidCallback onLongPress;

  const MemoryCard({
    super.key,
    required this.title,
    required this.isFavorite,
    required this.isNotificationOn,
    required this.imagePath,
    required this.onTap,
    required this.onLongPress,
    required this.isEditing,
    required this.controller,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 카드를 짧게 눌렀을 때 실행되는 동작
      onTap: onTap,

      // 카드를 길게 눌렀을 때 모달을 띄우는 동작
      onLongPress: onLongPress,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MARK: - 상단 이미지 및 즐겨찾기/알림 아이콘 영역
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              children: [
                // 카드에 지정된 이미지가 있을 경우 배경으로 표시
                if (imagePath != null)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(imagePath!, fit: BoxFit.cover),
                    ),
                  ),

                // 즐겨찾기 및 알림 상태 아이콘
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      // 즐겨찾기가 활성화된 경우에만 표시되는 아이콘
                      if (isFavorite)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Image.asset(
                            'assets/images/favorites.png',
                            width: 22,
                          ),
                        ),

                      // 알람 상태에 따라 다른 아이콘을 표시
                      Image.asset(
                        isNotificationOn
                            ? 'assets/images/bell_on.png'
                            : 'assets/images/bell_off.png',
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 카드 이미지와 제목 사이의 간격
          const SizedBox(height: 8),

          // MARK: - 하단 제목 영역 (일반/수정 모드)
          // MemoryCard 내부
          isEditing
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      autofocus: true,
                      style: AppFontStyle.M_18,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => onEditComplete(),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Color(0xFF6EA8EB), // 메인 블루
                    ),
                  ],
                )
              : Text(title, style: AppFontStyle.M_18),
        ],
      ),
    );
  }
}
