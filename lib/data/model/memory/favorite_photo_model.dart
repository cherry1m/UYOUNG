class FavoritePhoto {
  final String id;
  final String islandId;
  final String userId;
  final String photoKey;
  final DateTime? createdAt;

  const FavoritePhoto({
    required this.id,
    required this.islandId,
    required this.userId,
    required this.photoKey,
    required this.createdAt,
  });

  factory FavoritePhoto.fromMap(Map<String, dynamic> map) {
    return FavoritePhoto(
      id: (map['id'] ?? '') as String,
      islandId: (map['island_id'] ?? '') as String,
      userId: (map['user_id'] ?? '') as String,
      photoKey: (map['photo_key'] ?? '') as String,
      createdAt: map['created_at'] is String
          ? DateTime.tryParse(map['created_at'] as String)
          : null,
    );
  }
}
