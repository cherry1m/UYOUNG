import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/memory_card.dart';
import 'package:uyoung/src/view/pages/memory/memory_datail_page.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

class MemoryMainPage extends StatefulWidget {
  const MemoryMainPage({super.key});

  @override
  State<MemoryMainPage> createState() => _MemoryMainPageState();
}

class _MemoryMainPageState extends State<MemoryMainPage> {
  // MARK: - Overlay 관련 변수 롱프레스 시 뜨는 모달
  OverlayEntry? _overlayEntry;

  // MARK: - 선택된 카드 인덱스
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    // MARK: - 화면 진입 시 저장된 기억섬 데이터 로드
    Future.microtask(() => context.read<MemoryViewModel>().load());
  }

  @override
  void dispose() {
    // MARK: - Overlay 정리
    _removeOverlay();
    super.dispose();
  }

  // MARK: - Overlay 제거 함수
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    selectedIndex = null;
    setState(() {});
  }

  // MARK: - 카드 롱프레스 시 모달 띄우기
  void _showCardModal(BuildContext context, GlobalKey cardKey, int index) {
    _removeOverlay();
    selectedIndex = index;
    setState(() {});

    ///카드 위치, 사이즈 계산
    final render = cardKey.currentContext!.findRenderObject() as RenderBox;
    final pos = render.localToGlobal(Offset.zero);
    final size = render.size;

    // MARK: - OverlayEntry 생성
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            /// 배경 흐림 영역(클릭 → 닫힘)
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

            // MARK: - 선택한 컨테이너 바로 아래에 모달 배치
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

    /// Overlay 삽입
    Overlay.of(context).insert(_overlayEntry!);
  }

  // MARK: 모달 UI 구성
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
          // MARK: 모달 아이콘 및 이름 정리
          _modalItem("assets/images/edit.png", "이름 변경", () {
            vm.startEditing(index);
            _removeOverlay();
          }),

          _modalItem("assets/images/black_favorites.png", "즐겨찾기", () {
            vm.toggleFavorite(index);
            _removeOverlay();
          }),

          _modalItem(
            item.isNotificationOn
                ? "assets/images/bell_on.png"
                : "assets/images/bell_off.png",
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

  // MARK: - 모달 내부 버튼 UI
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

  // MARK: - "기억섬 나가기" 다이얼로그
  void _showExitDialog(int index) {
    final vm = context.read<MemoryViewModel>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
          title: Container(
            width: 330,
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/warning.png'),
                  width: 50,
                ),
                const SizedBox(height: 12),
                Text(
                  "정말 나가시겠어요?",
                  style: AppFontStyle.M_22,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "나가면 되돌릴 수 없습니다.",
                  style: AppFontStyle.M_20.copyWith(color: Color(0xFF707070)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          /// 버튼 영역
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            Row(
              children: [
                /// 취소 버튼
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F1F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "아니요",
                      style: AppFontStyle.M_18.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// 나가기 버튼
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF6EA8EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      vm.removeItem(index);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "네, 나갈게요",
                      style: AppFontStyle.M_18.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // MARK: - 화면 전체 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // MARK: - 상단 AppBar
      appBar: AppBar(
        title: Text("기억섬", style: AppFontStyle.M_20),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/search.png', width: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/chat.png', width: 55),
          ),
          const SizedBox(width: 12),
        ],
      ),

      // MARK: - 기억섬 리스트 그리드 뷰
      body: Consumer<MemoryViewModel>(
        builder: (context, vm, _) {
          if (!vm.isLoaded) return const SizedBox();

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            itemCount: vm.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final key = GlobalKey();

              return Opacity(
                opacity: selectedIndex == index
                    ? 1
                    : selectedIndex == null
                    ? 1
                    : 0.3,
                child: Transform.scale(
                  scale: selectedIndex == index ? 1.05 : 1.0,
                  child: Container(
                    key: key,
                    child: MemoryCard(
                      title: vm.items[index].title,
                      isFavorite: vm.items[index].isFavorite,
                      isNotificationOn: vm.items[index].isNotificationOn,
                      imagePath: vm.items[index].imagePath,
                      isEditing: vm.editingIndex == index,
                      controller: vm.textController,

                      /// 엔터 입력 시 이름 저장
                      onEditComplete: () {
                        vm.renameItem(index, vm.textController.text);
                        vm.stopEditing();
                      },

                      /// 카드 클릭 시 상세 페이지 이동
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MemoryDatailPage(item: vm.items[index]),
                          ),
                        );
                      },

                      /// 카드 롱프레스 시 모달 표시
                      onLongPress: () => _showCardModal(context, key, index),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
