import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/repositories/memory/memory_repository.dart';

class CreateMemoryViewModel extends ChangeNotifier {
  CreateMemoryViewModel({MemoryRepository? repository})
    : _repository = repository ?? MemoryRepository();

  static const int maxTitleLength = 12;
  static const List<String> palette = [
    '#FF6B6B',
    '#FF8E72',
    '#FFB26B',
    '#FFD56B',
    '#F4E76E',
    '#A4D96C',
    '#5FCD8C',
    '#54D2C6',
    '#6FD3FF',
    '#6EA8EB',
    '#7C93FF',
    '#9A7CFF',
    '#B780FF',
    '#E08EFF',
    '#FF94C2',
    '#D7B48C',
    '#B6BDC6',
    '#8B9AA9',
    '#5D6D7E',
    '#2D3A4A',
  ];

  final MemoryRepository _repository;
  final TextEditingController titleController = TextEditingController();

  String? selectedColor;
  XFile? selectedImage;
  Uint8List? selectedImageBytes;
  final List<InviteeUser> _selectedMembers = [];
  bool isSubmitting = false;

  List<InviteeUser> get selectedMembers => List.unmodifiable(_selectedMembers);
  bool get canProceedToMembers => selectedColor != null;
  bool get canSubmit => _selectedMembers.isNotEmpty;

  void onTitleChanged() {
    notifyListeners();
  }

  void setColor(String color) {
    selectedColor = color;
    notifyListeners();
  }

  Future<void> setSelectedImage(XFile file) async {
    selectedImage = file;
    selectedImageBytes = await file.readAsBytes();
    notifyListeners();
  }

  void setInvitees(List<InviteeUser> members) {
    _selectedMembers
      ..clear()
      ..addAll(members);
    notifyListeners();
  }

  void toggleInvitee(InviteeUser user) {
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

  bool isSelected(String userId) {
    return _selectedMembers.any((member) => member.id == userId);
  }

  Future<MemoryItem> createIsland() async {
    if (selectedColor == null) {
      throw StateError('기억섬 컬러를 선택해주세요.');
    }
    if (_selectedMembers.isEmpty) {
      throw StateError('초대할 멤버를 1명 이상 선택해주세요.');
    }

    isSubmitting = true;
    notifyListeners();

    try {
      final resolvedName = _resolveIslandName();
      final bgUrl = selectedImage == null
          ? null
          : await _repository.uploadIslandBackground(selectedImage!);

      final islandId = await _repository.createIslandWithMembers(
        islandName: resolvedName,
        color: selectedColor!,
        bgUrl: bgUrl,
        inviteeIds: _selectedMembers.map((user) => user.id).toList(),
      );

      return MemoryItem(
        id: islandId,
        title: resolvedName,
        isFavorite: false,
        isNotificationOn: true,
        imagePath: bgUrl,
      );
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  String _resolveIslandName() {
    final trimmed = titleController.text.trim();
    if (trimmed.isNotEmpty) {
      return trimmed;
    }

    if (_selectedMembers.length == 1) {
      return '${_selectedMembers.first.nickname}의 기억섬';
    }

    final names = _selectedMembers.take(2).map((user) => user.nickname).join(', ');
    return _selectedMembers.length > 2
        ? '$names 외 ${_selectedMembers.length - 2}명'
        : names;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
