import 'package:image_picker/image_picker.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/sources/supabase/user/profile_service.dart';

class ProfileRepository {
  ProfileRepository({ProfileService? service})
    : _service = service ?? ProfileService();

  final ProfileService _service;

  Future<AppUserProfile?> fetchCurrentProfile() async {
    try {
      return await _service.fetchCurrentProfile();
    } catch (error) {
      throw StateError('프로필 정보를 불러오지 못했어요. $error');
    }
  }

  Future<AppUserProfile> saveProfile({
    required String nickname,
    String? avatarUrl,
    XFile? selectedImage,
  }) async {
    if (nickname.trim().isEmpty) {
      throw StateError('닉네임을 입력해주세요.');
    }

    try {
      final resolvedAvatarUrl = selectedImage == null
          ? avatarUrl
          : await _service.uploadProfileImage(selectedImage);

      return await _service.saveProfile(
        nickname: nickname,
        avatarUrl: resolvedAvatarUrl,
      );
    } catch (error) {
      throw StateError('프로필 저장에 실패했어요. $error');
    }
  }
}
