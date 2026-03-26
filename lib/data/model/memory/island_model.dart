class IslandModel {
  final String id;
  final String name;
  final String ownerId;

  const IslandModel({
    required this.id,
    required this.name,
    required this.ownerId,
  });

  factory IslandModel.fromMap(Map<String, dynamic> map) {
    return IslandModel(
      id: map['id'] as String,
      name: (map['name'] ?? '') as String,
      ownerId: (map['owner_id'] ?? '') as String,
    );
  }
}

class IslandMemberModel {
  final String id;
  final String nickname;
  final String? avatarUrl;

  const IslandMemberModel({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
  });

  factory IslandMemberModel.fromProfileMap(Map<String, dynamic> map) {
    return IslandMemberModel(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
    );
  }

  String get displayName => nickname.isNotEmpty ? nickname : '이름 없음';
}
