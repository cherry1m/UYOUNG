import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/model/user/user_asset_model.dart';
import 'package:uyoung/data/repositories/user/profile_repository.dart';
import 'package:uyoung/data/repositories/user/user_asset_repository.dart';

class MyPageMainViewModel extends ChangeNotifier {
  MyPageMainViewModel({
    ProfileRepository? profileRepository,
    UserAssetRepository? userAssetRepository,
  }) : _profileRepository = profileRepository ?? ProfileRepository(),
       _userAssetRepository = userAssetRepository ?? UserAssetRepository();

  final ProfileRepository _profileRepository;
  final UserAssetRepository _userAssetRepository;

  static const String _appVersion = '1.0.0';

  AppUserProfile? _profile;
  int _pearlCount = 0;
  bool _isLoading = false;
  String? _errorText;

  AppUserProfile? get profile => _profile;
  int get pearlCount => _pearlCount;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;
  String get appVersion => _appVersion;

  String get displayName {
    final nickname = _profile?.nickname.trim();
    if (nickname != null && nickname.isNotEmpty) {
      return nickname;
    }
    return '이름 없음';
  }

  String get userCode {
    final code = _profile?.userCode.trim();
    if (code != null && code.isNotEmpty) {
      return code;
    }
    return '-';
  }

  String? get avatarUrl => _profile?.avatarUrl;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _profileRepository.fetchCurrentProfile(),
        _userAssetRepository.fetchUserAsset(),
      ]);

      _profile = results[0] as AppUserProfile?;
      _pearlCount = (results[1] as UserAsset).pearlCount;
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
