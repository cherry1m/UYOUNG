import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/memory/common_confirm_dialog.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class AlbumMemoryPage extends StatefulWidget {
  final MemoryItem item;

  const AlbumMemoryPage({super.key, required this.item, required String title});

  @override
  State<AlbumMemoryPage> createState() => _AlbumMemoryPageState();
}

class _AlbumMemoryPageState extends State<AlbumMemoryPage> {
  // MARK: - 임시 데이터
  final List<Map<String, dynamic>> albums = [
    {"title": "최근 항목", "count": 4, "image": "assets/images/sample11.png"},
    {"title": "즐겨찾기", "count": 4, "image": null},
    {"title": "카페 투어", "count": 4, "image": null},
    {"title": "오키나와", "count": 4, "image": null},
    {"title": "웃긴 사진 모음", "count": 4, "image": null},
  ];

  // MARK: - 이름 변경 상태
  int? editingIndex;
  final TextEditingController renameController = TextEditingController();

  // MARK: - 팝업 호출
  void _showAlbumPopup(GlobalKey cardKey, int index) {
    final render = cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (render == null) return;

    final pos = render.localToGlobal(Offset.zero);
    final size = render.size;
    final screenWidth = MediaQuery.of(context).size.width;

    const double popupWidth = 220;
    double popupLeft = pos.dx;

    if (popupLeft + popupWidth > screenWidth) {
      popupLeft = screenWidth - popupWidth - 16;
    }

    if (popupLeft < 16) {
      popupLeft = 16;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.35),
      barrierDismissible: true,
      builder: (_) {
        return Stack(
          children: [
            Positioned(
              left: popupLeft,
              top: pos.dy + size.height + 6,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: popupWidth,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // MARK: 이름 변경
                      _popupItem(
                        icon: "assets/images/edit.png",
                        label: "이름 변경",
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            editingIndex = index;
                            renameController.text = albums[index]["title"];
                          });
                        },
                      ),

                      _divider(),

                      // MARK: 삭제하기
                      _popupItem(
                        icon: "assets/images/exit.png",
                        label: "삭제하기",
                        color: const Color(0xFFE34B32),
                        onTap: () {
                          Navigator.pop(context);
                          showCommonConfirmDialog(
                            context,
                            title: "정말 삭제하시겠어요?",
                            subtitle: "${albums[index]["title"]} 앨범이 삭제됩니다.",
                            confirmLabel: "삭제할게요",
                            cancelLabel: "취소",
                            onConfirm: () {
                              setState(() {
                                albums.removeAt(index);
                                editingIndex = null;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // MARK: 팝업 아이템
  Widget _popupItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Image.asset(icon, width: 20, height: 20, color: color),
            const SizedBox(width: 10),
            Text(label, style: AppFontStyle.M_18.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
    height: 1,
    color: const Color(0xFFE6E6E6),
    margin: const EdgeInsets.symmetric(vertical: 4),
  );

  // MARK: - UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: widget.item.title, post: null),

      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        itemCount: albums.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final item = albums[index];
          final cardKey = GlobalKey();

          return GestureDetector(
            onLongPress: () {
              if (editingIndex == null) _showAlbumPopup(cardKey, index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MARK: 정사각형 이미지
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    key: cardKey,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.circular(14),
                      image: item["image"] != null
                          ? DecorationImage(
                              image: AssetImage(item["image"]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // MARK: 이름 변경 상태 TextField
                editingIndex == index
                    ? TextField(
                        controller: renameController,
                        autofocus: true,
                        textAlign: TextAlign.left,
                        onSubmitted: (text) {
                          setState(() {
                            albums[index]["title"] = text.trim();
                            editingIndex = null;
                          });
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF6EA8EB),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF6EA8EB),
                              width: 2,
                            ),
                          ),
                        ),
                        style: AppFontStyle.M_16,
                      )
                    : Text(
                        item["title"],
                        style: AppFontStyle.M_16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                const SizedBox(height: 2),

                // MARK: 사진 개수
                Text(
                  "${item["count"]}개",
                  style: AppFontStyle.M_14.copyWith(
                    color: const Color(0xFF707070),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
