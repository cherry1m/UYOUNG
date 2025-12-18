import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/data/sources/memory/memory_storage.dart';
import 'package:uyoung/src/view/pages/ocean/template_result_page.dart';
import 'package:uyoung/src/view/pages/ocean/widgets/template_photo_bottom_panel.dart';

class TemplatePhotoSelectPage extends StatefulWidget {
  final String templatePreviewPath;
  const TemplatePhotoSelectPage({super.key, required this.templatePreviewPath});

  @override
  State<TemplatePhotoSelectPage> createState() =>
      _TemplatePhotoSelectPageState();
}

class _TemplatePhotoSelectPageState extends State<TemplatePhotoSelectPage> {
  final MemoryStorage _storage = MemoryStorage();

  bool _loading = true;

  List<MemoryItem> _items = [];
  MemoryItem? _selectedIsland;

  // ✅ 1~3장 멀티 선택
  final List<String> _selectedPhotoPaths = [];

  // ✅ 현재 섬의 이미지들
  List<String> _currentPhotoAssets = [];

  MemoryItem get _recentItem => MemoryItem(
    id: "recent",
    title: "최근 항목",
    isFavorite: false,
    isNotificationOn: false,
    imagePath: "",
  );

  String _previewPathBySelectedCount() {
    final c = _selectedPhotoPaths.length;
    if (c == 0) return 'assets/images/temp_select.png';
    if (c == 1) return 'assets/images/temp_select_1.png';
    if (c == 2) return 'assets/images/temp_select_2.png';
    return 'assets/images/temp_select_3.png';
  }

  @override
  void initState() {
    super.initState();
    _loadMemoryIslands();
  }

  Future<void> _loadMemoryIslands() async {
    final items = await _storage.loadItems();
    final merged = <MemoryItem>[_recentItem, ...items];

    setState(() {
      _items = merged;
      _selectedIsland = merged.isNotEmpty ? merged.first : null;
      _loading = false;
    });

    _reloadPhotosForSelectedIsland();
  }

  void _reloadPhotosForSelectedIsland() {
    final sel = _selectedIsland;
    if (sel == null) return;

    final assets = <String>[];

    if (sel.id == "recent") {
      for (final entry in MemoryPostDummy.postsByMemoryId.entries) {
        for (final MemoryPostModel post in entry.value) {
          assets.addAll(post.images);
        }
      }
    } else {
      final posts = MemoryPostDummy.postsByMemoryId[sel.id] ?? [];
      for (final MemoryPostModel post in posts) {
        assets.addAll(post.images);
      }
    }

    setState(() {
      _currentPhotoAssets = assets;
      _selectedPhotoPaths.clear();
    });
  }

  void _openIslandBottomSheet() {
    if (_items.isEmpty) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (_) {
        return IslandSelectBottomSheet(
          items: _items,
          selectedId: _selectedIsland?.id,
          onSelect: (item) {
            setState(() => _selectedIsland = item);
            Navigator.pop(context);
            _reloadPhotosForSelectedIsland();
          },
        );
      },
    );
  }

  void _toggleSelectPhoto(String path) {
    final selectedIndex = _selectedPhotoPaths.indexOf(path);
    final isSelected = selectedIndex != -1;

    setState(() {
      if (isSelected) {
        _selectedPhotoPaths.removeAt(selectedIndex);
      } else {
        if (_selectedPhotoPaths.length >= 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사진은 최대 3장까지 선택할 수 있어요!')),
          );
          return;
        }
        _selectedPhotoPaths.add(path);
      }
    });
  }

  void _removeSelected(String path) {
    setState(() => _selectedPhotoPaths.remove(path));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final canNext = _selectedPhotoPaths.isNotEmpty;
    final nextLabel = canNext ? '다음(${_selectedPhotoPaths.length})' : '다음';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: Column(
        children: [
          // ✅ 상단 프리뷰
          Center(
            child: Container(
              width: 175,
              height: 311,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 24,
                    spreadRadius: 0,
                    color: Color(0x14000000),
                  ),
                ],
              ),
              child: ClipRRect(
                child: Image.asset(
                  _previewPathBySelectedCount(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ✅ 하단 패널 (분리된 위젯)
          TemplatePhotoBottomSheetPanel(
            height: 418,
            title: _selectedIsland?.title ?? '최근 항목',
            onTapTitle: _openIslandBottomSheet,

            // 그리드에 필요한 데이터/콜백
            photos: _currentPhotoAssets,
            selected: _selectedPhotoPaths,
            onTapPhoto: _toggleSelectPhoto,

            canNext: canNext,
            nextLabel: nextLabel,
            onNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TemplateResultPage()),
              );
            },
            onRemoveSelected: _removeSelected,
          ),
        ],
      ),
    );
  }
}
