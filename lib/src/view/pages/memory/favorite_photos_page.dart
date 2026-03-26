import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/memory/favorite_photo_model.dart';
import 'package:uyoung/src/view/pages/memory/photo_detail_page.dart';
import 'package:uyoung/src/viewModel/memory/favorite_photo_view_model.dart';

class FavoritePhotosPage extends StatelessWidget {
  const FavoritePhotosPage({
    super.key,
    required this.islandId,
  });

  final String islandId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritePhotoViewModel(islandId: islandId)..load(),
      child: const _FavoritePhotosView(),
    );
  }
}

class _FavoritePhotosView extends StatelessWidget {
  const _FavoritePhotosView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoritePhotoViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('즐겨찾는 사진', style: AppFontStyle.M_20),
      ),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorText != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  viewModel.errorText!,
                  textAlign: TextAlign.center,
                  style: AppFontStyle.M_16.copyWith(color: Colors.redAccent),
                ),
              ),
            );
          }

          if (viewModel.photos.isEmpty) {
            return Center(
              child: Text(
                '아직 즐겨찾기한 사진이 없어요',
                style: AppFontStyle.M_16.copyWith(color: Colors.grey),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: viewModel.photos.length,
            itemBuilder: (_, index) => _FavoritePhotoTile(photo: viewModel.photos[index]),
          );
        },
      ),
    );
  }
}

class _FavoritePhotoTile extends StatelessWidget {
  const _FavoritePhotoTile({required this.photo});

  final FavoritePhoto photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (photo.photoKey.startsWith('assets/')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PhotoDetailPage(
                imagePath: photo.photoKey,
                uploaderName: '버블 메이트',
                uploaderProfile: ImagePath.friendProfile,
              ),
            ),
          );
          return;
        }

        // TODO(choseoungeun): network/photo_key 상세 화면 연결 시 실제 메타데이터와 연결
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사진 상세 연결은 추후 연동 예정이에요.')),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (photo.photoKey.startsWith('http://') || photo.photoKey.startsWith('https://')) {
      return Image.network(
        photo.photoKey,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _FavoritePhotoPlaceholder(),
      );
    }

    return Image.asset(
      photo.photoKey,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _FavoritePhotoPlaceholder(),
    );
  }
}

class _FavoritePhotoPlaceholder extends StatelessWidget {
  const _FavoritePhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.image_outlined, color: Color(0xFFBDBDBD), size: 36),
    );
  }
}
