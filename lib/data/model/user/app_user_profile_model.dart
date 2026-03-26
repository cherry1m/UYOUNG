class AppUserProfile {
  final String id;
  final String nickname;
  final String? avatarUrl;
  final String userCode;
  final DateTime? createdAt;

  const AppUserProfile({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.userCode,
    required this.createdAt,
  });

  bool get needsSetup => nickname.trim().isEmpty;

  AppUserProfile copyWith({
    String? id,
    String? nickname,
    String? avatarUrl,
    String? userCode,
    DateTime? createdAt,
  }) {
    return AppUserProfile(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userCode: userCode ?? this.userCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AppUserProfile.fromMap(Map<String, dynamic> map) {
    return AppUserProfile(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
      userCode: (map['user_code'] ?? '') as String,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toUpsertMap() {
    return {
      'id': id,
      'nickname': nickname,
      'avatar_url': avatarUrl,
    };
  }
}
