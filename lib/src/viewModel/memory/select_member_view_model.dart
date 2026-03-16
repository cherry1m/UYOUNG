import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/repositories/memory/memory_repository.dart';

class SelectMemberViewModel extends ChangeNotifier {
  SelectMemberViewModel({MemoryRepository? repository})
    : _repository = repository ?? MemoryRepository();

  final MemoryRepository _repository;

  final List<InviteeUser> _searchResults = [];
  Timer? _debounce;
  bool isLoading = false;
  String? errorText;

  List<InviteeUser> get searchResults => List.unmodifiable(_searchResults);

  void scheduleSearch(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => search(keyword),
    );
  }

  Future<void> search(String keyword) async {
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
