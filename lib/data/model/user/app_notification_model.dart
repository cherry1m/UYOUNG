enum AppNotificationType {
  invite,
  activity,
  notice,
  unknown;

  static AppNotificationType fromValue(String? value) {
    switch (value) {
      case 'invite':
        return AppNotificationType.invite;
      case 'activity':
        return AppNotificationType.activity;
      case 'notice':
        return AppNotificationType.notice;
      default:
        return AppNotificationType.unknown;
    }
  }
}

class AppNotification {
  final String id;
  final String userId;
  final AppNotificationType type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime? createdAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    final title =
        (map['title'] ??
                map['category'] ??
                map['notification_title'] ??
                '') as String;
    final body =
        (map['body'] ??
                map['message'] ??
                map['content'] ??
                map['notification_body'] ??
                '') as String;

    return AppNotification(
      id: (map['id'] ?? '') as String,
      userId: (map['user_id'] ?? '') as String,
      type: AppNotificationType.fromValue(map['type'] as String?),
      title: title,
      body: body,
      isRead: (map['is_read'] ?? false) as bool,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'] as String),
    );
  }

  AppNotification copyWith({
    String? id,
    String? userId,
    AppNotificationType? type,
    String? title,
    String? body,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
