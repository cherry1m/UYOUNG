import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  static const double _tabBarHeight = 52;

  // MARK: - 이미지 선택
  Future<void> _pickImage() async {
    debugPrint("FAB CLICKED");

    // iOS simulator: gallery may not work depending on environment
    if (!kIsWeb && Platform.isIOS && !Platform.isAndroid) {
      debugPrint("iOS simulator detected: gallery may be unavailable");
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      debugPrint("Selected file: ${pickedFile.path}");
    } else {
      debugPrint("Image picking cancelled");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // MARK: - UI Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // MARK: 상단 앱바
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(widget.item.title, style: AppFontStyle.M_20),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MemberInquiryPage(),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/menu.png', width: 22),
                ),
              ],
            )
          : null,

      // MARK: PageView 본문
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => selectedIndex = i),
            children: [
              AllMemoryPage(title: widget.item.title, memoryId: widget.item.id),
              DateMemoryPage(item: widget.item),
              TimelineMemoryPage(title: widget.item.title, item: widget.item),
              AlbumMemoryPage(title: widget.item.title, item: widget.item),
            ],
          ),

          // MARK: 둥둥 떠있는 탭바 + 사진 추가 버튼
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 탭 버튼 컨테이너 (높이 고정)
                  Expanded(
                    child: SizedBox(
                      height: _tabBarHeight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _modeButton("전체", 0)),
                            const SizedBox(width: 6),
                            Expanded(child: _modeButton("일자별", 1)),
                            const SizedBox(width: 6),
                            Expanded(child: _modeButton("타임라인", 2)),
                            const SizedBox(width: 6),
                            Expanded(child: _modeButton("즐겨찾기", 3)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 사진 추가 버튼
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 46,
                      height: 46,
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
                      child: const Center(
                        child: Image(
                          image: AssetImage('assets/images/image_add.png'),
                          width: 26,
                        ),
                      ),
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

  // MARK: - 모드 버튼 UI
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
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD8E8FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: AppFontStyle.M_16.copyWith(
              color: isSelected
                  ? const Color(0xFF6EA8EB)
                  : const Color(0xFFA0A0A0),
            ),
          ),
        ),
      ),
    );
  }
}
