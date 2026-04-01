import 'package:flutter/material.dart';
import 'package:uyoung/data/repositories/user/user_asset_repository.dart';

class PearlViewModel extends ChangeNotifier {
  PearlViewModel({UserAssetRepository? repository})
    : _repository = repository ?? UserAssetRepository();

  final UserAssetRepository _repository;

  int _pearlCount = 0;
  bool _isLoading = false;
  String? _errorText;

  int get pearlCount => _pearlCount;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;
  String get pearlCountLabel => '$_pearlCount개';

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      final asset = await _repository.fetchUserAsset();
      _pearlCount = asset.pearlCount;
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
