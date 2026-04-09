import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/notice_item_model.dart';
import 'package:uyoung/data/repositories/user/notice_repository.dart';

class NoticeListViewModel extends ChangeNotifier {
  NoticeListViewModel({NoticeRepository? repository})
    : _repository = repository ?? NoticeRepository();

  final NoticeRepository _repository;

  List<NoticeItem> _notices = const [];
  bool _isLoading = false;
  String? _errorText;

  List<NoticeItem> get notices => _notices;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _notices = await _repository.fetchNotices();
    } catch (error) {
      _errorText = error.toString();
      _notices = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
