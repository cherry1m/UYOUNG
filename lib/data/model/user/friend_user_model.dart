class FriendUser {
  const FriendUser({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.userCode,
  });

  final String id;
  final String nickname;
  final String? avatarUrl;
  final String userCode;

  String get displayName => nickname.trim().isNotEmpty ? nickname.trim() : userCode;

  factory FriendUser.fromMap(Map<String, dynamic> map) {
    return FriendUser(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
      userCode: (map['user_code'] ?? '') as String,
    );
  }
}
