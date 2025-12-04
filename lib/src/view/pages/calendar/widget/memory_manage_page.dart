import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/src/view/pages/calendar/widget/memory_detail_page.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';

class MemoryIslandManagePage extends StatefulWidget {
  const MemoryIslandManagePage({super.key});

  @override
  State<MemoryIslandManagePage> createState() => _MemoryIslandManagePageState();
}

class _MemoryIslandManagePageState extends State<MemoryIslandManagePage> {
  /// 정렬 모드 여부
  bool _isSortMode = false;

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();
    final List<MemoryIsland> islands = calendarVM.islands;

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

            const SizedBox(height: 24),

            // 섹션 타이틀
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                '내 기억섬',
                style: AppFontStyle.S6.copyWith(color: const Color(0xFF707070)),
              ),
            ),

            const SizedBox(height: 24),

            // 리스트 영역
            Expanded(
              child: _isSortMode
                  ? _buildReorderableList(islands, calendarVM)
                  : _buildNormalList(islands),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 상단 헤더 영역 (X 아이콘 / 타이틀 / 정렬 아이콘)
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

          // 정렬 아이콘 (위/아래 화살 아이콘 영역)
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _isSortMode = !_isSortMode;
              });
            },
            icon: ImageData(path: ImagePath.sortUpDown, width: 40, height: 40),
          ),
        ],
      ),
    );
  }

  /// 🔹 공통으로 쓰는 한 줄 UI (점 + 텍스트 + 오른쪽 아이콘슬롯)
  Widget _buildIslandRow({
    required MemoryIsland island,
    required Widget trailing,
  }) {
    return SizedBox(
      height: 25, // 한 줄 높이 고정 (원하는 값으로 조절)
      child: Row(
        children: [
          // 컬러 점
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: island.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),

          // 이름
          Expanded(
            child: Text(
              island.name,
              style: AppFontStyle.M_16.copyWith(color: AppColors.gray_17),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 오른쪽 아이콘 (normal: 꺽쇠, sort: 햄버거)
          trailing,
        ],
      ),
    );
  }

  Widget _buildNormalList(List<MemoryIsland> islands) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: islands.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final island = islands[index];

        return InkWell(
          onTap: () {
            // 기억섬 상세 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MemoryIslandDetailPage(islandIndex: index),
              ),
            );
          },
          child: _buildIslandRow(
            island: island,
            trailing: ImageData(
              path: ImagePath.chevronRight,
              width: 12,
              height: 12,
            ),
          ),
        );
      },
    );
  }

  /// 🔹 정렬 모드 리스트 (ReorderableListView)
  Widget _buildReorderableList(
    List<MemoryIsland> islands,
    CalendarViewModel calendarVM,
  ) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: islands.length,
      buildDefaultDragHandles: false, // 우리가 직접 햄버거 아이콘으로 drag handle 만듦
      itemBuilder: (context, index) {
        final island = islands[index];

        return Padding(
          key: ValueKey(island.name),
          padding: const EdgeInsets.only(bottom: 24), // normal 모드와 동일 간격
          child: _buildIslandRow(
            island: island,
            trailing: ReorderableDragStartListener(
              index: index,
              child: ImageData(
                path: ImagePath.hamburgerBar,
                width: 30,
                height: 30,
              ),
            ),
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        calendarVM.reorderIslands(oldIndex, newIndex);
      },
    );
  }
}
