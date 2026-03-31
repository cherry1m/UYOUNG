import 'package:uyoung/data/model/memory/island_model.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/data/sources/supabase/memory/island_service.dart';

class IslandRepository {
  IslandRepository({IslandService? service})
    : _service = service ?? IslandService();

  final IslandService _service;

  Future<IslandModel> fetchIsland(String islandId) async {
    try {
      final island = await _service.fetchIsland(islandId);
      if (island == null) {
        throw StateError('기억섬을 찾을 수 없어요.');
      }
      return island;
    } catch (error) {
      throw StateError('기억섬 정보를 불러오지 못했어요. $error');
    }
  }

  Future<List<AppUserProfile>> fetchIslandMembers(String islandId) async {
    try {
      return await _service.fetchIslandMembers(islandId);
    } catch (error) {
      throw StateError('멤버 정보를 불러오지 못했어요. $error');
    }
  }

  Future<void> inviteMembersToIsland({
    required String islandId,
    required List<String> selectedUserIds,
  }) async {
    try {
      await _service.inviteMembersToIsland(
        islandId: islandId,
        selectedUserIds: selectedUserIds,
      );
    } catch (error) {
      throw StateError('멤버를 초대하지 못했어요. $error');
    }
  }
}
