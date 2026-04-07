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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
