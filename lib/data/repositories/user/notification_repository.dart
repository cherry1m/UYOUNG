import 'package:uyoung/data/model/user/app_notification_model.dart';
import 'package:uyoung/data/sources/supabase/user/notification_service.dart';

class NotificationRepository {
  NotificationRepository({NotificationService? service})
    : _service = service ?? NotificationService();

  final NotificationService _service;

  Future<List<AppNotification>> fetchNotifications() async {
    try {
      return await _service.fetchNotifications();
    } catch (error) {
      throw StateError('알림을 불러오지 못했어요. $error');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _service.markNotificationAsRead(notificationId);
    } catch (error) {
      throw StateError('알림을 읽음 처리하지 못했어요. $error');
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    try {
      await _service.markAllNotificationsAsRead();
    } catch (error) {
      throw StateError('알림 전체 읽음 처리에 실패했어요. $error');
    }
  }
}
