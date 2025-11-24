import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/pages/memory/album_memory_page.dart';
import 'package:uyoung/src/view/pages/memory/all_memory_page.dart';
import 'package:uyoung/src/view/pages/memory/date_memory_page.dart';
import 'package:uyoung/src/view/pages/memory/member_inquiry_page.dart';

import 'package:uyoung/src/view/pages/memory/timeline_memory_page.dart';

class MemoryDetailPage extends StatefulWidget {
  final MemoryItem item;

  const MemoryDetailPage({super.key, required this.item});

  @override
  State<MemoryDetailPage> createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends State<MemoryDetailPage> {
  int selectedIndex = 0; // 0: 전체, 1: 일자별, 2: 타임라인, 3: 앨범
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // MARK: - 상단 AppBar (전체 페이지에서만 보임)
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true, // 제목 중앙 유지
              title: Text(widget.item.title, style: AppFontStyle.M_20),

              actions: [
                IconButton(
                  onPressed: () => MemberInquiryPage(),
                  icon: Image.asset(
                    'assets/images/menu.png',
                    width: 22,
                    height: 22,
                  ),
                ),
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,

      // MARK: - 본문: PageView 스와이프 구조
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => selectedIndex = i),
        children: [
          // MARK: 전체
          AllMemoryPage(title: widget.item.title),

          // MARK: 일자별
          DateMemoryPage(title: widget.item.title, item: widget.item),

          // MARK: 타임라인
          TimelineMemoryPage(title: widget.item.title, item: widget.item),

          // MARK: 앨범
          AlbumMemoryPage(title: widget.item.title, item: widget.item),
        ],
      ),

      // MARK: - 하단 플로팅 버튼
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _bottomFloatingBar(context),
    );
  }

  // MARK: - 하단 플로팅 Bar
  Widget _bottomFloatingBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Stack(
        clipBehavior: Clip.none, // overflow 허용
        alignment: Alignment.centerRight,
        children: [
          // MARK: - 버튼 컨테이너
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            width: MediaQuery.of(context).size.width * 0.82,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0).withOpacity(0.9),
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            // MARK: - 4개 모드 버튼
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _modeButton("전체", 0),
                _modeButton("일자별", 1),
                _modeButton("타임라인", 2),
                _modeButton("앨범", 3),
              ],
            ),
          ),

          // MARK: - 플러스 버튼 (+)
          Positioned(
            right: -4,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF6EA8EB),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Image(
                  image: AssetImage('assets/images/image_add.png'),
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - 선택 가능한 모드 버튼
  Widget _modeButton(String label, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD8E8FF) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: AppFontStyle.M_16.copyWith(
            color: isSelected
                ? const Color(0xFF6EA8EB)
                : const Color(0xFFA0A0A0),
          ),
        ),
      ),
    );
  }
}
