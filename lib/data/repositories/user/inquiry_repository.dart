import 'package:uyoung/data/model/user/inquiry_item_model.dart';
import 'package:uyoung/data/sources/supabase/user/inquiry_service.dart';

class InquiryRepository {
  InquiryRepository({InquiryService? service})
    : _service = service ?? InquiryService();

  final InquiryService _service;

  Future<List<InquiryItem>> fetchMyInquiries() async {
    try {
      return await _service.fetchMyInquiries();
    } catch (error) {
      throw StateError('문의 내역을 불러오지 못했어요. $error');
    }
  }
}
