class NoticeItem {
  const NoticeItem({
    required this.id,
    required this.title,
    required this.body,
    required this.isImportant,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String body;
  final bool isImportant;
  final DateTime? createdAt;

  factory NoticeItem.fromMap(Map<String, dynamic> map) {
    return NoticeItem(
      id: (map['id'] ?? '') as String,
      title: (map['title'] ?? map['notice_title'] ?? '') as String,
      body: (map['body'] ?? map['content'] ?? map['notice_body'] ?? '') as String,
      isImportant: (map['is_important'] ?? false) as bool,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'] as String),
    );
  }
}
