import 'package:flutter/material.dart';
import 'package:uyoung/src/view/common/navigation/uyoung_bottom_nav_bar.dart';
import 'package:uyoung/src/view/pages/home/home_main.dart';
import 'package:uyoung/src/view/pages/home/store_page.dart';
import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';
import 'package:uyoung/src/view/pages/calendar/calendar_main_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/mypage_main_screen.dart';

class UyoungApp extends StatefulWidget {
  final int initialIndex;

  const UyoungApp({
    super.key,
    this.initialIndex = 0, // 기본 탭
  });

  @override
  State<UyoungApp> createState() => _UyoungAppState();
}

class _UyoungAppState extends State<UyoungApp> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // ✅ 여기서 초기 탭 설정
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeMain(), // 0
            MemoryMainPage(), // 1 기억섬
            CalendarMainPage(), // 2 캘린더
            StorePage(), // 3 상점
            MyPageMainScreen(), // 4
          ],
        ),
      ),
      bottomNavigationBar: UyoungBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
