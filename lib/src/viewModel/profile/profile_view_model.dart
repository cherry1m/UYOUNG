import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/repositories/user/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({ProfileRepository? repository})
    : _repository = repository ?? ProfileRepository();

  final ProfileRepository _repository;

  final TextEditingController nicknameController = TextEditingController();

  AppUserProfile? _profile;
  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorText;

  AppUserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get errorText => _errorText;
  Uint8List? get selectedImageBytes => _selectedImageBytes;
  String? get currentAvatarUrl => _profile?.avatarUrl;
  bool get canSave => nicknameController.text.trim().isNotEmpty && !_isSaving;
  bool get needsSetup => _profile == null || (_profile?.needsSetup ?? true);

  Future<void> loadProfile() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _profile = await _repository.fetchCurrentProfile();
      _syncControllers();
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onNicknameChanged() {
    notifyListeners();
  }

  Future<void> pickProfileImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }

    _selectedImage = pickedImage;
    _selectedImageBytes = await pickedImage.readAsBytes();
    notifyListeners();
  }

  Future<bool> saveProfile() async {
    _isSaving = true;
    _errorText = null;
    notifyListeners();

    try {
      _profile = await _repository.saveProfile(
        nickname: nicknameController.text,
        avatarUrl: _profile?.avatarUrl,
        selectedImage: _selectedImage,
      );
      _selectedImage = null;
      _selectedImageBytes = null;
      _syncControllers();
      return true;
    } catch (error) {
      _errorText = error.toString();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void _syncControllers() {
    nicknameController.text = _profile?.nickname ?? nicknameController.text;
  }

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }
}
