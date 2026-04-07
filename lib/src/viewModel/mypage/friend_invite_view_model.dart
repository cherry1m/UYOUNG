import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/repositories/user/friend_repository.dart';
import 'package:uyoung/data/repositories/user/profile_repository.dart';
import 'package:uyoung/data/repositories/user/user_search_repository.dart';

class FriendInviteViewModel extends ChangeNotifier {
  FriendInviteViewModel({
    FriendRepository? friendRepository,
    UserSearchRepository? userSearchRepository,
    ProfileRepository? profileRepository,
  }) : _friendRepository = friendRepository ?? FriendRepository(),
       _userSearchRepository = userSearchRepository ?? UserSearchRepository(),
       _profileRepository = profileRepository ?? ProfileRepository();

  final FriendRepository _friendRepository;
  final UserSearchRepository _userSearchRepository;
  final ProfileRepository _profileRepository;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;
  List<InviteeUser> _searchResults = const [];
  Set<String> _friendIds = {};
  Set<String> _justAddedIds = {};
  String _myCode = '-';
  bool _isLoading = false;
  bool _isSearching = false;
  bool _isSubmittingCode = false;
  String? _errorText;

  List<InviteeUser> get searchResults => _searchResults;
  Set<String> get friendIds => _friendIds;
  Set<String> get justAddedIds => _justAddedIds;
  String get myCode => _myCode;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get isSubmittingCode => _isSubmittingCode;
  String? get errorText => _errorText;

  Future<void> load({List<String> initialFriendIds = const []}) async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      final profile = await _profileRepository.fetchCurrentProfile();
      _myCode = profile?.userCode.trim().isNotEmpty == true ? profile!.userCode : '-';
      _friendIds = initialFriendIds.toSet();
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void scheduleSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => search(query));
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = const [];
      _errorText = null;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _errorText = null;
    notifyListeners();

    try {
      _searchResults = await _userSearchRepository.searchUsers(query);
    } catch (error) {
      _errorText = error.toString();
      _searchResults = const [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  Future<String?> addByCode() async {
    _isSubmittingCode = true;
    _errorText = null;
    notifyListeners();

    try {
      await _friendRepository.addFriendByCode(codeController.text);
      codeController.clear();
      return '친구를 추가했어요.';
    } catch (error) {
      _errorText = error.toString();
      return null;
    } finally {
      _isSubmittingCode = false;
      notifyListeners();
    }
  }

  Future<String?> addDirect(InviteeUser user) async {
    if (_friendIds.contains(user.id)) {
      return '이미 친구예요.';
    }

    try {
      await _friendRepository.addFriendDirect(user.id);
      _friendIds = {..._friendIds, user.id};
      _justAddedIds = {..._justAddedIds, user.id};
      notifyListeners();
      return '${user.displayName}님을 친구로 추가했어요.';
    } catch (error) {
      _errorText = error.toString();
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    codeController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
