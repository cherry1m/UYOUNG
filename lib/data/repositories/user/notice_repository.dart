import 'package:uyoung/data/model/user/notice_item_model.dart';
import 'package:uyoung/data/sources/supabase/user/notice_service.dart';

class NoticeRepository {
  NoticeRepository({NoticeService? service})
    : _service = service ?? NoticeService();

  final NoticeService _service;

  Future<List<NoticeItem>> fetchNotices() async {
    try {
      return await _service.fetchNotices();
    } catch (error) {
      throw StateError('공지사항을 불러오지 못했어요. $error');
    }
  }

  Future<NoticeItem> fetchNoticeDetail(String noticeId) async {
    try {
      return await _service.fetchNoticeDetail(noticeId);
    } catch (error) {
      throw StateError('공지사항 상세를 불러오지 못했어요. $error');
    }
  }
}
