import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/data/repositories/user/friend_repository.dart';
import 'package:uyoung/data/repositories/user/profile_repository.dart';

class FriendAddByCodeViewModel extends ChangeNotifier {
  FriendAddByCodeViewModel({
    FriendRepository? friendRepository,
    ProfileRepository? profileRepository,
  }) : _friendRepository = friendRepository ?? FriendRepository(),
       _profileRepository = profileRepository ?? ProfileRepository();

  final FriendRepository _friendRepository;
  final ProfileRepository _profileRepository;

  final TextEditingController codeController = TextEditingController();

  FriendUser? _foundUser;
  Set<String> _friendIds = {};
  String? _myUserId;
  bool _isSearching = false;
  bool _isSubmitting = false;
  String? _errorText;
  String? _infoText;

  FriendUser? get foundUser => _foundUser;
  bool get isSearching => _isSearching;
  bool get isSubmitting => _isSubmitting;
  String? get errorText => _errorText;
  String? get infoText => _infoText;
  bool get canAddFoundUser =>
      _foundUser != null &&
      !_friendIds.contains(_foundUser!.id) &&
      _foundUser!.id != _myUserId;

  Future<void> load({List<String> initialFriendIds = const []}) async {
    _friendIds = initialFriendIds.toSet();
    final profile = await _profileRepository.fetchCurrentProfile();
    _myUserId = profile?.id;
    notifyListeners();
  }

  Future<void> searchByCode() async {
    final inputCode = codeController.text.trim();
    if (inputCode.isEmpty) {
      _errorText = '친구 코드를 입력해주세요.';
      _infoText = null;
      _foundUser = null;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _errorText = null;
    _infoText = null;
    _foundUser = null;
    notifyListeners();

    try {
      final user = await _friendRepository.findUserByCode(inputCode);
      if (user == null) {
        _infoText = '일치하는 친구 코드를 찾지 못했어요.';
        return;
      }

      _foundUser = user;
      if (user.id == _myUserId) {
        _infoText = '내 코드는 친구로 추가할 수 없어요.';
      } else if (_friendIds.contains(user.id)) {
        _infoText = '이미 친구로 추가된 사용자예요.';
      }
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  Future<String?> addFoundUser() async {
    final user = _foundUser;
    if (user == null) {
      _errorText = '먼저 친구 코드를 검색해주세요.';
      notifyListeners();
      return null;
    }

    if (user.id == _myUserId) {
      _errorText = '내 코드는 친구로 추가할 수 없어요.';
      notifyListeners();
      return null;
    }

    if (_friendIds.contains(user.id)) {
      _errorText = '이미 친구로 추가된 사용자예요.';
      notifyListeners();
      return null;
    }

    _isSubmitting = true;
    _errorText = null;
    notifyListeners();

    try {
      await _friendRepository.addFriendDirect(user.id);
      _friendIds = {..._friendIds, user.id};
      _infoText = '${user.displayName}님을 친구로 추가했어요.';
      return _infoText;
    } catch (error) {
      _errorText = error.toString();
      return null;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
