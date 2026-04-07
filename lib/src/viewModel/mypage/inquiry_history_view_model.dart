import 'package:flutter/material.dart';
import 'package:uyoung/data/model/user/inquiry_item_model.dart';
import 'package:uyoung/data/repositories/user/inquiry_repository.dart';

class InquiryHistoryViewModel extends ChangeNotifier {
  InquiryHistoryViewModel({InquiryRepository? repository})
    : _repository = repository ?? InquiryRepository();

  final InquiryRepository _repository;

  List<InquiryItem> _inquiries = const [];
  bool _isLoading = false;
  String? _errorText;

  List<InquiryItem> get inquiries => _inquiries;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future<void> load() async {
    _isLoading = true;
    _errorText = null;
    notifyListeners();

    try {
      _inquiries = await _repository.fetchMyInquiries();
    } catch (error) {
      _errorText = error.toString();
      _inquiries = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
