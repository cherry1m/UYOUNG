class InviteeUser {
  final String id;
  final String nickname;
  final String? avatarUrl;

  const InviteeUser({
    required this.id,
    required this.nickname,
    this.avatarUrl,
  });

  factory InviteeUser.fromMap(Map<String, dynamic> map) {
    return InviteeUser(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
    );
  }
}
