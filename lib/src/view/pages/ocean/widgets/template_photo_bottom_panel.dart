import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class TemplatePhotoBottomSheetPanel extends StatelessWidget {
  final double height;

  final String title;
  final VoidCallback onTapTitle;

  final List<String> photos;
  final List<String> selected;
  final ValueChanged<String> onTapPhoto;

  final bool canNext;
  final String nextLabel;
  final VoidCallback? onNext;

  final ValueChanged<String> onRemoveSelected;

  const TemplatePhotoBottomSheetPanel({
    super.key,
    required this.height,
    required this.title,
    required this.onTapTitle,
    required this.photos,
    required this.selected,
    required this.onTapPhoto,
    required this.canNext,
    required this.nextLabel,
    required this.onNext,
    required this.onRemoveSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // ✅ 418 고정
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              blurRadius: 26,
              spreadRadius: 0,
              color: Color(0x14000000),
            ),
          ],
        ),
        child: Column(
          children: [
            // 핸들
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD8D8D8),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 16),

            // 드롭다운 (가운데)
            GestureDetector(
              onTap: onTapTitle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: AppFontStyle.H6),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 22),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 그리드
            SizedBox(
              height: 180, // 시안처럼 2줄 보이게
              child: _PhotoGrid(
                photos: photos,
                selected: selected,
                onTapPhoto: onTapPhoto,
              ),
            ),

            const SizedBox(height: 5),

            // 안내 + 다음(카운트)
            Row(
              children: [
                Text('메인 사진을 선택해 주세요!', style: AppFontStyle.H7),
                const Spacer(),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: canNext ? onNext : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.mainBlue,
                      disabledBackgroundColor: const Color(0xFFE3E6EB),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      nextLabel,
                      style: AppFontStyle.H7.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 선택 썸네일 바
            _SelectedThumbBar(selected: selected, onRemove: onRemoveSelected),
          ],
        ),
      ),
    );
  }
}

/// ✅ 그리드
class _PhotoGrid extends StatelessWidget {
  final List<String> photos;
  final List<String> selected;
  final ValueChanged<String> onTapPhoto;

  const _PhotoGrid({
    required this.photos,
    required this.selected,
    required this.onTapPhoto,
  });

  @override
  Widget build(BuildContext context) {
    // 시안: 사진 없으면 2줄(=8칸) 채워보이게
    final itemCount = 1 + (photos.isEmpty ? 7 : photos.length);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _AddPhotoTile(onTap: () {});
        }

        final photoIndex = index - 1;
        final hasPhoto = photoIndex < photos.length;

        if (!hasPhoto) return _PhotoPlaceholderTile(onTap: () {});

        final path = photos[photoIndex];
        final selectedIndex = selected.indexOf(path);
        final isSelected = selectedIndex != -1;

        return _PhotoAssetTile(
          assetPath: path,
          isSelected: isSelected,
          selectedOrder: isSelected ? (selectedIndex + 1) : null,
          onTap: () => onTapPhoto(path),
        );
      },
    );
  }
}

/// ✅ 선택된 썸네일 바(하단)
class _SelectedThumbBar extends StatelessWidget {
  final List<String> selected;
  final ValueChanged<String> onRemove;

  const _SelectedThumbBar({required this.selected, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (selected.isEmpty) return const SizedBox(height: 70);

    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: selected.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final path = selected[i];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  path,
                  width: 62,
                  height: 62,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => onRemove(path),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6FA2E6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ✅ 드롭다운 바텀시트: 기억섬 리스트
class IslandSelectBottomSheet extends StatelessWidget {
  final List<MemoryItem> items;
  final String? selectedId;
  final ValueChanged<MemoryItem> onSelect;

  const IslandSelectBottomSheet({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              offset: Offset(0, 8),
              color: Color(0x22000000),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in items)
              InkWell(
                onTap: () => onSelect(item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(item.title, style: AppFontStyle.H7)),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade400),
                          color: item.id == selectedId
                              ? AppColors.mainBlue
                              : Colors.transparent,
                        ),
                        child: item.id == selectedId
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddPhotoTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: AppColors.mainBlue, size: 28),
              const SizedBox(height: 6),
              Text(
                '사진 추가',
                style: AppFontStyle.H9.copyWith(color: AppColors.mainBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoPlaceholderTile extends StatelessWidget {
  final VoidCallback onTap;
  const _PhotoPlaceholderTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

/// ✅ 실제 사진 타일 + 선택 순번(상단 중앙)
class _PhotoAssetTile extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;
  final int? selectedOrder;

  const _PhotoAssetTile({
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    this.selectedOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(assetPath, fit: BoxFit.cover)),
            if (isSelected && selectedOrder != null)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.mainBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$selectedOrder',
                      style: AppFontStyle.H9.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
