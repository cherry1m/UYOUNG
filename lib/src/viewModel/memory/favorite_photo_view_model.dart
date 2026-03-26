import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/favorite_photo_model.dart';
import 'package:uyoung/data/repositories/memory/favorite_photo_repository.dart';

class FavoritePhotoViewModel extends ChangeNotifier {
  FavoritePhotoViewModel({
    required this.islandId,
    FavoritePhotoRepository? repository,
  }) : _repository = repository ?? FavoritePhotoRepository();

  final String islandId;
  final FavoritePhotoRepository _repository;

  List<FavoritePhoto> _photos = const [];
  bool _isLoading = false;
  String? _errorText;

  List<FavoritePhoto> get photos => List.unmodifiable(_photos);
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _photos = await _repository.getMyFavoritePhotos(islandId);
    } catch (error) {
      _photos = const [];
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleFavorite(String photoKey) async {
    try {
      final isFavorite = await _repository.toggleFavoritePhoto(
        islandId: islandId,
        photoKey: photoKey,
      );

      if (!isFavorite) {
        _photos = _photos.where((photo) => photo.photoKey != photoKey).toList();
        notifyListeners();
      } else {
        await load();
      }

      return isFavorite;
    } catch (error) {
      _errorText = error.toString();
      notifyListeners();
      rethrow;
    }
  }
}
