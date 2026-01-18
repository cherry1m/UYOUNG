import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';

class MemoryIslandDetailPage extends StatefulWidget {
  final MemoryIsland island;
  final DateTime date;

  const MemoryIslandDetailPage({
    super.key,
    required this.island,
    required this.date,
  });

  @override
  State<MemoryIslandDetailPage> createState() => _MemoryIslandDetailPageState();
}

class _MemoryIslandDetailPageState extends State<MemoryIslandDetailPage> {
  /// 이 섬에서 이 날짜에 해당하는 모든 사진 경로
  late List<String> _thumbPaths;

  /// 선택 모드 on/off
  bool _isSelectionMode = false;

  /// 선택된 인덱스들
  final Set<int> _selectedIndexes = {};

  @override
  void initState() {
    super.initState();

    _thumbPaths = widget.island.photoThumbnails.entries
        .where((entry) => entry.key.isSameDay(widget.date))
        .map((e) => e.value)
        .toList();
  }

  /// 선택 모드 토글
  void _toggleSelectionMode() {
    setState(() {
      if (_isSelectionMode) {
        // 모드 끌 때 선택 초기화
        _isSelectionMode = false;
        _selectedIndexes.clear();
      } else {
        _isSelectionMode = true;
      }
    });
  }

  /// 특정 index 선택/해제
  void _onTapThumb(int index) {
    if (!_isSelectionMode) {
      // 선택 모드 아닐 때는 향후 전체보기 등으로 확장 가능
      // TODO: 단일 사진 전체보기 기능 연결
      return;
    }

    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  /// 선택된 사진 삭제 (현재는 로컬 리스트 기준)
  void _deleteSelected() {
    if (_selectedIndexes.isEmpty) return;

    setState(() {
      final sorted = _selectedIndexes.toList()..sort((a, b) => b.compareTo(a));
      for (final idx in sorted) {
        if (idx >= 0 && idx < _thumbPaths.length) {
          _thumbPaths.removeAt(idx);
        }
      }
      _selectedIndexes.clear();

      if (_thumbPaths.isEmpty) {
        _isSelectionMode = false;
      }
    });

    // TODO: ViewModel/데이터 소스와 실제 삭제 동기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      /// 선택 모드일 때만 하단 바 고정
      bottomNavigationBar: _isSelectionMode
          ? Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFEFEFF2), width: 1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${_selectedIndexes.length}장의 사진이 선택됨',
                        style: AppFontStyle.M_18,
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _selectedIndexes.isEmpty
                            ? null
                            : _deleteSelected,
                        child: Opacity(
                          opacity: _selectedIndexes.isEmpty ? 0.3 : 1.0,
                          child: Image.asset(ImagePath.trash, width: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,

      body: SafeArea(
        child: Column(
          children: [
            // 상단 영역 (뒤로가기, 이름, 날짜, 선택/취소 버튼)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              child: SizedBox(
                height: 40, // 헤더 높이 고정
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 가운데: 섬 이름 + 날짜 (항상 정확히 중앙)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.island.name,
                          style: AppFontStyle.H6,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일',
                          style: AppFontStyle.S9.copyWith(
                            color: AppColors.gray_12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    // 왼쪽: 뒤로가기 버튼
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),

                    // 오른쪽: 선택 아이콘 ↔ 취소 버튼
                    Align(
                      alignment: Alignment.centerRight,
                      child: _isSelectionMode
                          ? TextButton(
                              onPressed: _toggleSelectionMode,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                '삭제',
                                style: AppFontStyle.M_14.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: _toggleSelectionMode,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              constraints: const BoxConstraints(),
                              icon: Image.asset(
                                ImagePath.checkBlack,
                                width: 20,
                                height: 20,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 썸네일 그리드 영역
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  itemCount: _thumbPaths.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    final path = _thumbPaths[index];
                    final isSelected = _selectedIndexes.contains(index);

                    return GestureDetector(
                      onTap: () => _onTapThumb(index),
                      child: SizedBox(
                        width: 114,
                        height: 114,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(path, fit: BoxFit.cover),

                              // 선택된 경우 반투명 오버레이 (#00000033)
                              if (isSelected)
                                Container(color: const Color(0x33000000)),
                              if (isSelected)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Image.asset(
                                    ImagePath
                                        .checkedBlack, // ← 여기에 원하는 체크 이미지 경로 넣기
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
