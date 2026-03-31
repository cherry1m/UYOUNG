import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/repositories/memory/island_repository.dart';

class IslandInviteViewModel extends ChangeNotifier {
  IslandInviteViewModel({
    required this.islandId,
    required Iterable<String> existingMemberIds,
    IslandRepository? repository,
  }) : _existingMemberIds = existingMemberIds.toSet(),
       _repository = repository ?? IslandRepository();

  final String islandId;
  final Set<String> _existingMemberIds;
  final IslandRepository _repository;
  final List<InviteeUser> _selectedMembers = [];

  bool _isSubmitting = false;
  String? _errorText;

  Set<String> get existingMemberIds => Set.unmodifiable(_existingMemberIds);
  List<InviteeUser> get selectedMembers => List.unmodifiable(_selectedMembers);
  bool get isSubmitting => _isSubmitting;
  String? get errorText => _errorText;
  bool get canSubmit => _selectedMembers.isNotEmpty;

  bool isExistingMember(String userId) => _existingMemberIds.contains(userId);

  void toggleInvitee(InviteeUser user) {
    if (isExistingMember(user.id)) {
      return;
    }

    final index = _selectedMembers.indexWhere((member) => member.id == user.id);
    if (index >= 0) {
      _selectedMembers.removeAt(index);
    } else {
      _selectedMembers.add(user);
    }
    notifyListeners();
  }

  void removeInvitee(String userId) {
    _selectedMembers.removeWhere((member) => member.id == userId);
    notifyListeners();
  }

  Future<void> inviteMembers() async {
    if (_selectedMembers.isEmpty) {
      throw StateError('초대할 멤버를 1명 이상 선택해주세요.');
    }

    _isSubmitting = true;
    _errorText = null;
    notifyListeners();

    try {
      await _repository.inviteMembersToIsland(
        islandId: islandId,
        selectedUserIds: _selectedMembers.map((member) => member.id).toList(),
      );
    } catch (error) {
      _errorText = error.toString();
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
