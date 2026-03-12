// MARK: - MemoryItem Model
// 기억섬에서 하나의 카드를 표현하기 위한 데이터 모델이다.
// id, title, 즐겨찾기 여부, 알림 여부, 이미지 경로 등을 보관하고
// SharedPreferences 저장을 위해 Map 변환 기능도 포함하고 있다.

class MemoryItem {
  // 각 아이템을 구분하기 위한 고유 id.
  final String id;

  // 카드의 제목(유저가 수정 가능).
  String title;

  // 즐겨찾기 여부.
  bool isFavorite;

  // 알람 여부.
  bool isNotificationOn;

  // 카드에 표시되는 이미지 경로.
  String? imagePath;

  // 서버 최신 업데이트 시각.
  DateTime? updatedAt;

  // 카드에 노출할 참여 멤버 프리뷰.
  List<MemoryMemberPreview> members;

  // MARK: - 생성자
  // 전달된 값들을 이용해 MemoryItem 인스턴스를 생성한다.
  MemoryItem({
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.isNotificationOn,
    this.imagePath,
    this.updatedAt,
    this.members = const [],
  });

  factory MemoryItem.fromIslandMemberMap(
    Map<String, dynamic> map, {
    List<MemoryMemberPreview> members = const [],
  }) {
    final island = Map<String, dynamic>.from((map['islands'] ?? {}) as Map);

    return MemoryItem(
      id: island['id'] as String,
      title: (island['name'] ?? island['island_name'] ?? '') as String,
      isFavorite: (map['is_favorite'] ?? false) as bool,
      isNotificationOn: !((map['is_muted'] ?? false) as bool),
      imagePath: island['bg_image_url'] as String?,
      updatedAt: _parseDateTime(island['updated_at']),
      members: members,
    );
  }

  // MARK: - Map → MemoryItem 변환
  // SharedPreferences에서 불러온 Map 데이터를 모델 객체로 변환한다.
  factory MemoryItem.fromMap(Map<String, dynamic> map) {
    return MemoryItem(
      id: map['id'],
      title: map['title'],
      isFavorite: map['isFavorite'],
      isNotificationOn: map['isNotificationOn'],
      imagePath: map['imagePath'],
      updatedAt: _parseDateTime(map['updatedAt']),
      members: ((map['members'] ?? []) as List<dynamic>)
          .map((member) => MemoryMemberPreview.fromMap(Map<String, dynamic>.from(member as Map)))
          .toList(),
    );
  }

  // MARK: - MemoryItem → Map 변환
  // 데이터를 SharedPreferences에 저장할 수 있도록 Map 형태로 변환한다.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "isFavorite": isFavorite,
      "isNotificationOn": isNotificationOn,
      "imagePath": imagePath,
      "updatedAt": updatedAt?.toIso8601String(),
      "members": members.map((member) => member.toMap()).toList(),
    };
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is! String || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}

class MemoryMemberPreview {
  final String id;
  final String nickname;
  final String? avatarUrl;

  const MemoryMemberPreview({
    required this.id,
    required this.nickname,
    this.avatarUrl,
  });

  factory MemoryMemberPreview.fromMap(Map<String, dynamic> map) {
    return MemoryMemberPreview(
      id: map['id'] as String,
      nickname: (map['nickname'] ?? '') as String,
      avatarUrl: map['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'avatar_url': avatarUrl,
    };
  }
}
