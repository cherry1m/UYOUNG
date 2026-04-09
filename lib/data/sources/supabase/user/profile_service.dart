import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/storage_buckets.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class ProfileService {
  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  User get _currentUser {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('로그인이 필요합니다.');
    }
    return user;
  }

  Future<AppUserProfile?> fetchCurrentProfile() async {
    final response = await _client
        .from('profiles')
        .select('id, nickname, avatar_url, created_at, user_code')
        .eq('id', _currentUser.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AppUserProfile.fromMap(Map<String, dynamic>.from(response));
  }

  Future<AppUserProfile> saveProfile({
    required String nickname,
    String? avatarUrl,
  }) async {
    final existingProfile = await fetchCurrentProfile();

    if (existingProfile == null) {
      return insertProfile(nickname: nickname, avatarUrl: avatarUrl);
    }

    return updateProfile(nickname: nickname, avatarUrl: avatarUrl);
  }

  Future<AppUserProfile> insertProfile({
    required String nickname,
    String? avatarUrl,
  }) async {
    final user = _currentUser;
    final response = await _client
        .from('profiles')
        .insert(_buildPayload(user.id, nickname, avatarUrl))
        .select('id, nickname, avatar_url, created_at, user_code')
        .single();

    return AppUserProfile.fromMap(Map<String, dynamic>.from(response));
  }

  Future<AppUserProfile> updateProfile({
    required String nickname,
    String? avatarUrl,
  }) async {
    final user = _currentUser;
    final response = await _client
        .from('profiles')
        .update(_buildPayload(user.id, nickname, avatarUrl, includeId: false))
        .eq('id', user.id)
        .select('id, nickname, avatar_url, created_at, user_code')
        .single();

    return AppUserProfile.fromMap(Map<String, dynamic>.from(response));
  }

  Future<String> uploadProfileImage(XFile imageFile) async {
    final user = _currentUser;
    final bytes = await imageFile.readAsBytes();
    final originalName = imageFile.name.isEmpty ? 'profile.jpg' : imageFile.name;
    final sanitizedName = originalName.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
    final path =
        'profiles/${user.id}/${DateTime.now().microsecondsSinceEpoch}_$sanitizedName';

    await _client.storage.from(StorageBuckets.profileImages).uploadBinary(
      path,
      bytes,
      fileOptions: FileOptions(
        upsert: true,
        contentType: _contentTypeFor(sanitizedName),
      ),
    );

    return _client.storage
        .from(StorageBuckets.profileImages)
        .getPublicUrl(path);
  }

  Map<String, dynamic> _buildPayload(
    String userId,
    String nickname,
    String? avatarUrl, {
    bool includeId = true,
  }) {
    final payload = <String, dynamic>{
      'nickname': nickname.trim(),
      'avatar_url': avatarUrl?.trim().isEmpty == true ? null : avatarUrl?.trim(),
    };

    if (includeId) {
      payload['id'] = userId;
    }

    return payload;
  }

  String _contentTypeFor(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }
}
