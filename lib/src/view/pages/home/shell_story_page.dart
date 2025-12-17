import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/home/shell_story_model.dart';
import 'package:uyoung/data/sources/home/shell_story_dummy.dart';
import 'package:uyoung/src/view/pages/home/unfinished_shell_story_list_page.dart';

class ShellStoryPage extends StatelessWidget {
  const ShellStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(children: [_middle(context), _story()]),
      ),
    );
  }

  // MARK: 상단 AppBar
  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text("조개 이야기", style: AppFontStyle.H5),
    actions: [
      GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset("assets/images/filter.png", width: 42),
        ),
      ),
    ],
  );

  Widget _middle(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: SizedBox(
      height: 170,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "아직 완성되지 않은\n조개 이야기를 확인해 봐요!",
                        style: AppFontStyle.F2,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UnfinishedShellStoryListPage(),
                            ),
                          );
                        },
                        child: Text(
                          "자세히 보기 >",
                          style: AppFontStyle.S8.copyWith(
                            color: const Color(0xFF777777),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            right: -30,
            bottom: -10,
            child: Image.asset(
              "assets/images/shell_story.png",
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );

  // MARK: 조개 이야기 섹션
  Widget _story() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("우리의 조개 이야기", style: AppFontStyle.H6),
            Text(
              "총 ${shellStories.length} 개",
              style: AppFontStyle.S8.copyWith(color: const Color(0xFF666666)),
            ),
          ],
        ),
      ),

      const SizedBox(height: 16),

      Column(
        children: shellStories.map((story) {
          return _storyCard(
            story: story,
            onTap: () {
              // TODO: 상세 페이지 이동
            },
          );
        }).toList(),
      ),
    ],
  );
  Widget _storyCard({required ShellStory story, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            // MARK: 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                story.imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),

            // MARK: 프레임
            Positioned.fill(
              child: IgnorePointer(
                child: Image.asset(
                  "assets/images/memory_frame.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // MARK: 텍스트 오버레이
            Positioned(
              left: 16,
              right: 16,
              bottom: 56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFF0F0F0),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      story.tag,
                      style: AppFontStyle.H8.copyWith(
                        color: const Color(0xFFF0F0F0),
                      ),
                    ),
                  ),
                  Text(
                    story.title,
                    style: AppFontStyle.S5.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story.date,
                    style: AppFontStyle.H8.copyWith(
                      color: const Color(0xFCCCCCCC),
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
}
