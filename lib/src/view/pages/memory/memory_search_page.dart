import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/pages/memory/memory_card.dart';
import 'package:uyoung/src/view/pages/memory/memory_detail_page.dart';

class MemorySearchPage extends StatelessWidget {
  final List<MemoryItem> items;

  const MemorySearchPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("기억섬 검색", style: AppFontStyle.M_20),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MARK: 검색창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "검색어를 입력하세요.",
                      hintStyle: AppFontStyle.M_18.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image(
                    image: const AssetImage('assets/images/search.png'),
                    width: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Container(height: 1, color: const Color(0xFFE5E5E5)),
            const SizedBox(height: 16),

            // MARK: 최근 검색어
            Text("최근 검색어", style: AppFontStyle.M_18),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [
                _chip(context, "최보빈"),
                _chip(context, "우.정.포.에.버"),
                _chip(context, "이윤서"),
                _chip(context, "한승하"),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: _chip(context, "인덕대 솔모임🍹"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: _chip(context, "오키나와 팸✈️"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: _chip(context, "일본"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text("최근 자주 찾는 기억", style: AppFontStyle.M_18),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemoryDetailPage(item: item),
                        ),
                      );
                    },
                    child: MemoryCard(
                      title: item.title,
                      isFavorite: item.isFavorite,
                      isNotificationOn: item.isNotificationOn,
                      imagePath: item.imagePath,
                      isEditing: false,
                      controller: TextEditingController(),
                      onEditComplete: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MemoryDetailPage(item: item),
                          ),
                        );
                      },
                      onLongPress: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: 최근 검색어 chip 위젯
  Widget _chip(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        // 추후 이동할 곳 추가
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Text(label, style: AppFontStyle.M_16),
      ),
    );
  }
}
