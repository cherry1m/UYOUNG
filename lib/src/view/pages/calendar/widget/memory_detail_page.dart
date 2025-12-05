import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';

class MemoryIslandDetailPage extends StatelessWidget {
  final int islandIndex;

  const MemoryIslandDetailPage({Key? key, required this.islandIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();
    final island = calendarVM.islands[islandIndex];

    return Scaffold(
      backgroundColor: AppColors.white_01,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 바
            _buildTopBar(context),

            // 구분선
            Container(height: 1, color: AppColors.gray_03),

            // 선택된 기억섬 이름 + 색상
            _buildHeaderIslandInfo(island),

            // 섹션 구분선
            Container(
              height: 10,
              color: AppColors.gray_01, // 적당한 연회색 배경
            ),

            const SizedBox(height: 24),

            // "알림 설정" 타이틀
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                '알림 설정',
                style: AppFontStyle.S6.copyWith(color: const Color(0xFF707070)),
              ),
            ),

            const SizedBox(height: 16),

            // 알림 스위치 한 줄
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Text(
                    '알림',
                    style: AppFontStyle.M_16.copyWith(color: AppColors.gray_17),
                  ),
                  const Spacer(),

                  Transform.scale(
                    scale: 0.8, // 🔥 크기 축소
                    child: CupertinoSwitch(
                      value: island.alertEnabled, // 🔥 저장된 값 반영
                      onChanged: (value) {
                        context.read<CalendarViewModel>().toggleAlert(
                          islandIndex,
                          value,
                        ); // 🔥 ViewModel 업데이트
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 상단 헤더 (X 버튼 + 타이틀 + 정렬 아이콘 자리는 빈칸)
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
      child: Row(
        children: [
          // 닫기(X)
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, size: 26, color: Colors.black),
          ),

          const Spacer(),

          Text('기억섬 관리', style: AppFontStyle.M_20),

          const Spacer(),

          // 오른쪽은 정렬 아이콘 대신 빈 공간
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  /// 상단 기억섬 정보 한 줄 (이름 + 색 점 + 꺾쇠)
  Widget _buildHeaderIslandInfo(island) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Row(
        children: [
          // 이름
          Expanded(
            child: Text(
              island.name,
              style: AppFontStyle.M_18.copyWith(color: AppColors.gray_17),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 8),

          // 컬러 점
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: island.color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 8),

          // 우측 꺾쇠 아이콘 (나중에 이름/색상 수정 화면으로 이동할 때 사용)
          ImageData(path: ImagePath.chevronRight, width: 14, height: 14),
        ],
      ),
    );
  }
}
