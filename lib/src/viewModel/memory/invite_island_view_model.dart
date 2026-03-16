import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/island_invite_detail_model.dart';
import 'package:uyoung/data/repositories/memory/memory_repository.dart';

class InviteIslandViewModel extends ChangeNotifier {
  InviteIslandViewModel({
    required this.inviteCode,
    MemoryRepository? repository,
  }) : _repository = repository ?? MemoryRepository();

  final String inviteCode;
  final MemoryRepository _repository;

  IslandInviteDetail? detail;
  bool isLoading = false;
  bool isJoining = false;
  String? errorMessage;

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      detail = await _repository.fetchIslandInviteDetail(inviteCode);
      if (detail == null) {
        errorMessage = '유효하지 않은 초대 링크예요.';
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<IslandInviteDetail> join() async {
    isJoining = true;
    errorMessage = null;
    notifyListeners();

    try {
      final joined = await _repository.joinIslandByInviteCode(inviteCode);
      detail = joined;
      return joined;
    } catch (error) {
      errorMessage = error.toString();
      rethrow;
    } finally {
      isJoining = false;
      notifyListeners();
    }
  }
}
