import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/home/today_shell_frame_content.dart';
import 'package:uyoung/src/view/pages/home/today_shell_story_page.dart';
import 'widgets/unfinished_shell_story_card.dart';

class UnfinishedShellStoryListPage extends StatelessWidget {
  const UnfinishedShellStoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _card(),
    );
  }

  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text("채우지 못 한 조개 이야기", style: AppFontStyle.H5),
  );

  Widget _card() => Builder(
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.25,
          children: [
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory_seaotter2.png",
              tag: "일본팸 ✈️",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory_seaotter1.png",
              tag: "상콩즈 🐼",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory_seaotter3.png",
              tag: "물개 달란트 🐬",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/sample11.png",
              tag: "칼챔",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory/couple/couple.png",
              tag: "울 애깅",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory/alcohol/alcohol1.jpeg",
              tag: "술독 🍺",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
            UnfinishedShellStoryCard(
              imagePath: "assets/images/memory/europe/prague1.jpeg",
              tag: "유러피안",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodayShellStoryPage()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
