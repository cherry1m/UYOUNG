import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/notice_item_model.dart';
import 'package:uyoung/data/repositories/user/notice_repository.dart';

class NoticeDetailViewModel extends ChangeNotifier {
  NoticeDetailViewModel({
    required this.noticeId,
    NoticeRepository? repository,
  }) : _repository = repository ?? NoticeRepository();

  final String noticeId;
  final NoticeRepository _repository;

  NoticeItem? _notice;
  bool _isLoading = false;
  String? _errorText;

  NoticeItem? get notice => _notice;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _notice = await _repository.fetchNoticeDetail(noticeId);
    } catch (error) {
      _errorText = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
