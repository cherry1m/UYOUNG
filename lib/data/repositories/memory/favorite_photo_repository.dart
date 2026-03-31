import 'package:uyoung/data/model/memory/favorite_photo_model.dart';
import 'package:uyoung/data/sources/supabase/memory/favorite_photo_service.dart';

class FavoritePhotoRepository {
  FavoritePhotoRepository({FavoritePhotoService? service})
    : _service = service ?? FavoritePhotoService();

  final FavoritePhotoService _service;

  Future<List<FavoritePhoto>> getMyFavoritePhotos(String islandId) async {
    try {
      return await _service.getMyFavoritePhotos(islandId);
    } catch (error) {
      throw StateError('즐겨찾는 사진을 불러오지 못했어요. $error');
    }
  }

  Future<bool> toggleFavoritePhoto({
    required String islandId,
    required String photoKey,
  }) async {
    try {
      return await _service.toggleFavoritePhoto(
        islandId: islandId,
        photoKey: photoKey,
      );
    } catch (error) {
      throw StateError('즐겨찾기 상태를 변경하지 못했어요. $error');
    }
  }
}
