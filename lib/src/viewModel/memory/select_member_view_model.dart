import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/repositories/user/user_search_repository.dart';

class SelectMemberViewModel extends ChangeNotifier {
  SelectMemberViewModel({UserSearchRepository? repository})
    : _repository = repository ?? UserSearchRepository();

  final UserSearchRepository _repository;

  final List<InviteeUser> _searchResults = [];
  Timer? _debounce;
  bool isLoading = false;
  String? errorText;
  String _query = '';

  List<InviteeUser> get searchResults => List.unmodifiable(_searchResults);
  String get query => _query;

  void scheduleSearch(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => search(keyword),
    );
  }

  Future<void> search(String keyword) async {
    _query = keyword;
    isLoading = true;
    errorText = null;
    notifyListeners();

    try {
      final results = await _repository.searchUsers(keyword);
      _searchResults
        ..clear()
        ..addAll(results);
    } catch (error) {
      errorText = error.toString();
      _searchResults.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
