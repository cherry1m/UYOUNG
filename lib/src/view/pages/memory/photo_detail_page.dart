import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/widgets/change_day_sheet.dart';
import 'package:uyoung/src/view/pages/memory/widgets/comment_input_bar.dart';
import 'package:uyoung/src/view/pages/memory/widgets/location_sheet.dart';

class PlacedSticker {
  PlacedSticker({
    required this.assetPath,
    required this.dxRatio,
    required this.dyRatio,
    this.size = 72,
  });

  final String assetPath;
  double dxRatio; // 0~1
  double dyRatio; // 0~1
  double size;
}

class PhotoDetailPage extends StatefulWidget {
  // 전달받은 이미지 경로
  final String imagePath;

  // 전달받은 업로드한 사람 이름 및 프로필
  final String uploaderName;
  final String uploaderProfile;

  const PhotoDetailPage({
    super.key,
    required this.imagePath,
    required this.uploaderName,
    required this.uploaderProfile,
  });

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  final double _popupWidth = 220;

  // 확정된 스티커들
  final List<PlacedSticker> _stickers = [];

  // 임시(선택) 스티커: 사진 위에서 드래그로 위치 지정 후, 전송 시 확정
  String? _pendingStickerAsset;
  double _pendingDxRatio = 0.5;
  double _pendingDyRatio = 0.6;
  double _pendingSize = 72;

  // 사진 영역 크기 캐싱 (전송 시점 등에서 활용)
  double _photoWidth = 0;
  double _photoHeight = 530;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _body(context),
      bottomNavigationBar: CommentInputBar(
        uploaderProfile: widget.uploaderProfile,
        selectedSticker: _pendingStickerAsset,
        onStickerSelected: _onStickerSelected,
        onStickerRemoved: _onStickerRemoved,
        onSend: _onSend,
      ),
    );
  }

  // 상단 AppBar
  AppBar _appBar(BuildContext context) {
    final GlobalKey moreKey = GlobalKey();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text("일본 도쿄", style: AppFontStyle.H6),
          const SizedBox(height: 2),
          Text(
            "2025년 08월 14일 오후 3:38",
            style: AppFontStyle.S9.copyWith(color: const Color(0xff999999)),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Image(
            image: const AssetImage("assets/images/download.png"),
            width: 42,
          ),
        ),
        GestureDetector(
          key: moreKey,
          onTap: () => _showMorePopup(context, moreKey),
          child: const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Image(
              image: AssetImage("assets/images/more.png"),
              width: 22,
            ),
          ),
        ),
      ],
    );
  }

  // 더보기 아이콘 클릭 시 호출되는 팝업
  void _showMorePopup(BuildContext context, GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenWidth = MediaQuery.of(context).size.width;

    double left = position.dx - (_popupWidth - size.width);
    if (left < 16) left = 16;
    if (left + _popupWidth > screenWidth) {
      left = screenWidth - _popupWidth - 16;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      barrierDismissible: true,
      builder: (_) {
        return Stack(
          children: [
            Positioned(
              left: left,
              top: position.dy,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: _popupWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _popupItem(
                        imagePath: "assets/images/date.png",
                        label: "날짜 및 시간 조정",
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return Container(
                                height: 750,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: const ChangeDayPage(),
                              );
                            },
                          );
                        },
                      ),
                      _divider(),
                      _popupItem(
                        imagePath: "assets/images/location.png",
                        label: "위치 조정",
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return Container(
                                height: 750,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: LocationSheet(),
                              );
                            },
                          );
                        },
                      ),
                      _divider(),
                      _popupItem(
                        imagePath: "assets/images/delete.png",
                        label: "삭제하기",
                        color: const Color(0xFFE34B32),
                        onTap: () => Navigator.pop(context),
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

  Widget _popupItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.asset(imagePath, width: 20, height: 20),
            const SizedBox(width: 12),
            Text(label, style: AppFontStyle.M_16.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(height: 1, color: const Color(0xFFE6E6E6));

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _photoArea(),
          const SizedBox(height: 18),

          // 업로드한 사람 이름 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(widget.uploaderProfile),
                ),
                const SizedBox(width: 10),
                Text(
                  "${widget.uploaderName} 업로드",
                  style: AppFontStyle.S8.copyWith(
                    color: const Color(0xff999999),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/favorite.png",
                    width: 28,
                    height: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 사진 + 스티커 오버레이
  Widget _photoArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        _photoWidth = constraints.maxWidth;
        _photoHeight = 530;

        return SizedBox(
          width: double.infinity,
          height: _photoHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(widget.imagePath, fit: BoxFit.cover),

              // 확정된 스티커들
              for (int i = 0; i < _stickers.length; i++)
                _placedStickerWidget(_stickers[i], _photoWidth, _photoHeight),

              // 임시 스티커 (드래그로 위치 지정)
              if (_pendingStickerAsset != null)
                _pendingStickerWidget(_photoWidth, _photoHeight),
            ],
          ),
        );
      },
    );
  }

  Widget _placedStickerWidget(PlacedSticker s, double w, double h) {
    final left = (s.dxRatio * w) - (s.size / 2);
    final top = (s.dyRatio * h) - (s.size / 2);

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onLongPress: () => setState(() => _stickers.remove(s)),
        child: Image.asset(s.assetPath, width: s.size, height: s.size),
      ),
    );
  }

  Widget _pendingStickerWidget(double w, double h) {
    final left = (_pendingDxRatio * w) - (_pendingSize / 2);
    final top = (_pendingDyRatio * h) - (_pendingSize / 2);

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onPanUpdate: (d) {
          final newLeft = (left + d.delta.dx).clamp(
            -_pendingSize / 2,
            w - _pendingSize / 2,
          );
          final newTop = (top + d.delta.dy).clamp(
            -_pendingSize / 2,
            h - _pendingSize / 2,
          );

          setState(() {
            _pendingDxRatio = ((newLeft + _pendingSize / 2) / w).clamp(
              0.0,
              1.0,
            );
            _pendingDyRatio = ((newTop + _pendingSize / 2) / h).clamp(0.0, 1.0);
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              _pendingStickerAsset!,
              width: _pendingSize,
              height: _pendingSize,
            ),
            Positioned(
              right: -6,
              top: -6,
              child: GestureDetector(
                onTap: _onStickerRemoved,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CommentInputBar 콜백들
  void _onStickerSelected(String assetPath) {
    setState(() {
      _pendingStickerAsset = assetPath;
      _pendingDxRatio = 0.5;
      _pendingDyRatio = 0.6;
    });
  }

  void _onStickerRemoved() {
    setState(() {
      _pendingStickerAsset = null;
    });
  }

  void _onSend() {
    // 스티커가 선택되어 있으면 "현재 지정된 위치"에 확정
    if (_pendingStickerAsset != null) {
      setState(() {
        _stickers.add(
          PlacedSticker(
            assetPath: _pendingStickerAsset!,
            dxRatio: _pendingDxRatio,
            dyRatio: _pendingDyRatio,
            size: _pendingSize,
          ),
        );
        _pendingStickerAsset = null;
      });
      return;
    }

    // 스티커가 없으면 텍스트 댓글 전송 로직을 연결하면 됨
  }
}
