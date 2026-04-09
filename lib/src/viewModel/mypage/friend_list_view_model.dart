import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/data/repositories/user/friend_repository.dart';

class FriendListViewModel extends ChangeNotifier {
  FriendListViewModel({FriendRepository? repository})
    : _repository = repository ?? FriendRepository();

  final FriendRepository _repository;

  final TextEditingController searchController = TextEditingController();

  List<FriendUser> _friends = const [];
  bool _isLoading = false;
  Set<String> _deletingFriendIds = {};
  String? _errorText;

  List<FriendUser> get friends {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      return _friends;
    }

    return _friends.where((friend) {
      return friend.displayName.contains(query) || friend.userCode.contains(query);
    }).toList();
  }

  List<String> get friendIds => _friends.map((friend) => friend.id).toList();
  bool get isLoading => _isLoading;
  bool isDeleting(String friendId) => _deletingFriendIds.contains(friendId);
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _friends = await _repository.fetchFriends();
    } catch (error) {
      _errorText = error.toString();
      _friends = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onSearchChanged(String _) {
    notifyListeners();
  }

  Future<void> deleteFriend(String friendId) async {
    if (_deletingFriendIds.contains(friendId)) {
      return;
    }

    final previousFriends = _friends;
    _deletingFriendIds = {..._deletingFriendIds, friendId};
    _friends = _friends.where((friend) => friend.id != friendId).toList();
    _errorText = null;
    notifyListeners();

    try {
      await _repository.deleteFriend(friendId);
    } catch (error) {
      _friends = previousFriends;
      _errorText = error.toString();
      rethrow;
    } finally {
      _deletingFriendIds = {..._deletingFriendIds}..remove(friendId);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
