import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/memory/common_confirm_dialog.dart';
import 'package:uyoung/src/view/pages/memory/create_memory_page.dart';
import 'package:uyoung/src/view/pages/memory/memory_card.dart';
import 'package:uyoung/src/view/pages/memory/memory_detail_page.dart';
import 'package:uyoung/src/view/pages/memory/memory_search_page.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

class MemoryMainPage extends StatefulWidget {
  const MemoryMainPage({super.key});

  @override
  State<MemoryMainPage> createState() => _MemoryMainPageState();
}

class _MemoryMainPageState extends State<MemoryMainPage> {
  // MARK: - Overlay 관련 상태
  OverlayEntry? _overlayEntry;

  // MARK: - 현재 선택된 카드 index
  int? selectedIndex;

  // MARK: - 초기 데이터 로드
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MemoryViewModel>().load());
  }

  // MARK: - Overlay 해제
  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  // MARK: - Overlay 제거 메서드
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    selectedIndex = null;
    setState(() {});
  }

  // MARK: - 카드 롱프레스 시 모달 표시
  void _showCardModal(BuildContext context, GlobalKey cardKey, int index) {
    _removeOverlay();
    selectedIndex = index;
    setState(() {});

    final render = cardKey.currentContext!.findRenderObject() as RenderBox;
    final pos = render.localToGlobal(Offset.zero);
    final size = render.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // MARK: - 어두운 배경 클릭 시 닫힘
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

            // MARK: - 카드 아래에 모달 위치 고정
            Positioned(
              left: pos.dx,
              top: pos.dy + size.height + 8,
              child: Material(
                color: Colors.transparent,
                child: _buildModal(index, size.width),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // MARK: - 카드 옵션 모달 UI
  Widget _buildModal(int index, double width) {
    final vm = context.read<MemoryViewModel>();
    final item = vm.items[index];

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modalItem("assets/images/edit.png", "이름 변경", () {
            vm.startEditing(index);
            _removeOverlay();
          }),
          const Divider(height: 1),

          _modalItem("assets/images/black_favorites.png", "즐겨찾기", () {
            vm.toggleFavorite(index);
            _removeOverlay();
          }),
          const Divider(height: 1),

          _modalItem(
            item.isNotificationOn
                ? "assets/images/alert.png"
                : "assets/images/alert.png",
            item.isNotificationOn ? "알람 끄기" : "알람 켜기",
            () {
              vm.toggleAlarm(index);
              _removeOverlay();
            },
          ),
          const Divider(height: 1),

          _modalItem("assets/images/exit.png", "기억섬 나가기", () {
            _removeOverlay();
            _showExitDialog(index);
          }, isRed: true),
        ],
      ),
    );
  }

  // MARK: - 모달 내부 버튼 공통 위젯
  Widget _modalItem(
    String iconPath,
    String label,
    VoidCallback onTap, {
    bool isRed = false,
  }) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 20,
        height: 20,
        color: isRed ? Colors.red : Colors.black,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isRed ? Colors.red : Colors.black,
          fontFamily: "memomentKkukkkuk",
        ),
      ),
      onTap: onTap,
    );
  }

  // MARK: - 기억섬 나가기 확인 다이얼로그
  void _showExitDialog(int index) {
    final vm = context.read<MemoryViewModel>();

    showCommonConfirmDialog(
      context,
      title: "정말 나가시겠어요?",
      subtitle: "나가면 되돌릴 수 없습니다.",
      confirmLabel: "네, 나갈게요",
      cancelLabel: "아니요",
      onConfirm: () => vm.removeItem(index),
    );
  }

  // MARK: - 기억섬 메인 화면 UI
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MemoryViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,

      // MARK: - 상단 앱바
      appBar: AppBar(
        title: Text("기억섬", style: AppFontStyle.M_20),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // MARK: - 검색 페이지 이동
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MemorySearchPage(items: vm.items),
                ),
              );
            },
            icon: Image.asset('assets/images/search.png', width: 24),
          ),

          // MARK: - 기억섬 생성 페이지 이동
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateMemoryPage()),
              );
            },
            icon: Image.asset('assets/images/chat.png', width: 55),
          ),
          const SizedBox(width: 12),
        ],
      ),

      // MARK: - 콘텐츠 영역
      body: vm.isLoaded == false
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemCount: vm.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 170 / 150,
              ),
              itemBuilder: (context, index) {
                final key = GlobalKey();

                return MemoryCard(
                  key: key,
                  title: vm.items[index].title,
                  imagePath: vm.items[index].imagePath,
                  isFavorite: vm.items[index].isFavorite,
                  isNotificationOn: vm.items[index].isNotificationOn,
                  isEditing: vm.editingIndex == index,
                  controller: vm.textController,

                  // MARK: - 이름 수정 완료 처리
                  onEditComplete: () {
                    vm.renameItem(index, vm.textController.text);
                    vm.stopEditing();
                  },

                  // MARK: - 카드 클릭 시 상세 이동
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MemoryDetailPage(item: vm.items[index]),
                      ),
                    );
                  },

                  // MARK: - 카드 롱프레스 시 옵션 모달
                  onLongPress: () => _showCardModal(context, key, index),
                );
              },
            ),
    );
  }
}
