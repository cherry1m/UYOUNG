class InviteeUser {
  final String id;
  final String nickname;
  final String? avatarUrl;
  final String userCode;

  const InviteeUser({
    required this.id,
    required this.nickname,
    this.avatarUrl,
    required this.userCode,
  });

  factory InviteeUser.fromMap(Map<String, dynamic> map) {
    return InviteeUser(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
      userCode: (map['user_code'] ?? '') as String,
    );
  }

  String get displayName => nickname.isNotEmpty ? nickname : userCode;
}
