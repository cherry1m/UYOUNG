import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/island_model.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/repositories/memory/island_repository.dart';

class IslandDetailViewModel extends ChangeNotifier {
  IslandDetailViewModel({
    required this.islandId,
    IslandRepository? repository,
  }) : _repository = repository ?? IslandRepository();

  final String islandId;
  final IslandRepository _repository;

  IslandModel? _island;
  List<AppUserProfile> _members = const [];
  bool _isLoading = false;
  String? _errorText;

  IslandModel? get island => _island;
  List<AppUserProfile> get members => List.unmodifiable(_members);
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.fetchIsland(islandId),
        _repository.fetchIslandMembers(islandId),
      ]);

      _island = results[0] as IslandModel;
      _members = results[1] as List<AppUserProfile>;
    } catch (error) {
      _errorText = error.toString();
      _members = const [];
      _island = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
