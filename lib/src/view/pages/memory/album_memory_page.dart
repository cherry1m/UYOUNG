import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class AlbumMemoryPage extends StatefulWidget {
  final MemoryItem item;

  const AlbumMemoryPage({super.key, required this.item, required String title});

  @override
  State<AlbumMemoryPage> createState() => _AlbumMemoryPageState();
}

class _AlbumMemoryPageState extends State<AlbumMemoryPage> {
  final List<String?> favoriteImages = [
    "assets/images/memory/shangkong/hongkong7.jpeg",
    "assets/images/memory/shangkong/hongkong9.jpeg",
    "assets/images/memory/shangkong/hongkong10.jpeg",
    "assets/images/memory/shangkong/hongkong1.jpeg",
    "assets/images/memory/shangkong/shanghi7.jpeg",
    "assets/images/memory/shangkong/shanghi1.jpeg",
    "assets/images/memory/shangkong/hongkong21.jpeg",
    "assets/images/memory/shangkong/hongkong22.jpeg",
    "assets/images/memory/shangkong/hongkong16.jpeg",
    "assets/images/memory/shangkong/hongkong17.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(
        title: widget.item.title,
        islandId: widget.item.id,
      ),
      body: _photoGrid(),
    );
  }

  Widget _photoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      itemCount: favoriteImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1, // 정사각형
      ),
      itemBuilder: (context, index) {
        final path = favoriteImages[index];
        return _photoTile(path);
      },
    );
  }

  Widget _photoTile(String? assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        color: const Color(0xFFEAEAEA),
        child: assetPath == null
            ? const SizedBox.expand()
            : Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
