import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/sources/supabase/user/user_search_service.dart';

class UserSearchRepository {
  UserSearchRepository({UserSearchService? service})
    : _service = service ?? UserSearchService();

  final UserSearchService _service;

  Future<List<InviteeUser>> searchUsers(String query) async {
    try {
      return await _service.searchUsers(query);
    } catch (error) {
      throw StateError('사용자 검색에 실패했어요. $error');
    }
  }
}
