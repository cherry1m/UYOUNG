import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/home/today_shell_frame_content.dart';

class TodayShellStoryPage extends StatefulWidget {
  const TodayShellStoryPage({super.key});

  @override
  State<TodayShellStoryPage> createState() => _TodayShellStoryPageState();
}

class _TodayShellStoryPageState extends State<TodayShellStoryPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/seacontent_background.png",
                fit: BoxFit.cover,
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 8),
                _appBar(),
                const SizedBox(height: 12),
                _titleSection(),
                const SizedBox(height: 12),

                Expanded(child: _mainFramePager()),

                const SizedBox(height: 12),

                _pageIndicator(),

                const SizedBox(height: 16),

                _progressSection(),

                const SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MARK: AppBar
  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios),
          const Spacer(),
          Image.asset("assets/images/menu.png", width: 24),
        ],
      ),
    );
  }

  // MARK: 타이틀
  Widget _titleSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/small_shell_left.png", width: 18),
            const SizedBox(width: 6),
            Text(
              "조개 속에 넣을 오늘의 이야기",
              style: AppFontStyle.S8.copyWith(color: const Color(0xFF666666)),
            ),
            const SizedBox(width: 6),
            Image.asset("assets/images/small_shell_right.png", width: 18),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "최근 우리가 제일 웃겼던\n순간은 언제였을까?",
          textAlign: TextAlign.center,
          style: AppFontStyle.F2,
        ),
      ],
    );
  }

  // MARK: 중앙 PageView
  Widget _mainFramePager() {
    return PageView.builder(
      controller: _pageController,
      itemCount: 4,
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
      itemBuilder: (_, __) => _mainFrame(_currentPage),
    );
  }

  // MARK: 프레임 1장
  Widget _mainFrame(int index) {
    final frameData = todayShellFrameContents[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/seacontent_frame.png",
            fit: BoxFit.contain,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(frameData.image, width: 180, height: 180),

              const SizedBox(height: 12),

              Text(frameData.title, style: AppFontStyle.H6),

              const SizedBox(height: 6),

              Text(
                frameData.actionText,
                style: AppFontStyle.S7.copyWith(color: const Color(0xFF666666)),
              ),

              const SizedBox(height: 28),

              Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Image.asset(
                      frameData.profileImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Text(
                      frameData.name,
                      style: AppFontStyle.H7.copyWith(
                        color: const Color(0xFF4880ED),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // MARK: 페이지 인디케이터 (실제 동작)
  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Image.asset(
            i == _currentPage
                ? "assets/images/shell_filled.png"
                : "assets/images/shell_empty.png",
            width: 16,
          ),
        ),
      ),
    );
  }

  // MARK: 하단 알림 영역 (크기 키움)
  Widget _progressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SizedBox(
        height: 130,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Image.asset(
              "assets/images/seacontent_alret.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 64, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "조개가 기억으로 가득 차면, 진주가 탄생해요!",
                    style: AppFontStyle.H7,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "현재 이 기억섬의 달성률은 32 %",
                    style: AppFontStyle.S8.copyWith(
                      color: const Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
