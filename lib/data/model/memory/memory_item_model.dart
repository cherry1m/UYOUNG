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

  // MARK: - 생성자
  // 전달된 값들을 이용해 MemoryItem 인스턴스를 생성한다.
  MemoryItem({
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.isNotificationOn,
    this.imagePath,
  });

  // MARK: - Map → MemoryItem 변환
  // SharedPreferences에서 불러온 Map 데이터를 모델 객체로 변환한다.
  factory MemoryItem.fromMap(Map<String, dynamic> map) {
    return MemoryItem(
      id: map['id'],
      title: map['title'],
      isFavorite: map['isFavorite'],
      isNotificationOn: map['isNotificationOn'],
      imagePath: map['imagePath'],
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
    };
  }
}
