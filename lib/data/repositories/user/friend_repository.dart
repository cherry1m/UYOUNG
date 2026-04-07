import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/data/sources/supabase/user/friend_service.dart';

class FriendRepository {
  FriendRepository({FriendService? service})
    : _service = service ?? FriendService();

  final FriendService _service;

  Future<List<FriendUser>> fetchFriends() async {
    try {
      return await _service.fetchFriends();
    } catch (error) {
      throw StateError('친구 목록을 불러오지 못했어요. $error');
    }
  }

  Future<void> addFriendByCode(String inputCode) async {
    if (inputCode.trim().isEmpty) {
      throw StateError('친구 코드를 입력해주세요.');
    }

    try {
      await _service.addFriendByCode(inputCode);
    } catch (error) {
      throw StateError('코드로 친구를 추가하지 못했어요. $error');
    }
  }

  Future<void> addFriendDirect(String friendId) async {
    try {
      await _service.addFriendDirect(friendId);
    } catch (error) {
      throw StateError('친구를 추가하지 못했어요. $error');
    }
  }

  Future<FriendUser?> findUserByCode(String inputCode) async {
    if (inputCode.trim().isEmpty) {
      throw StateError('친구 코드를 입력해주세요.');
    }

    try {
      return await _service.findUserByCode(inputCode);
    } catch (error) {
      throw StateError('친구 코드를 검색하지 못했어요. $error');
    }
  }

  Future<void> deleteFriend(String friendId) async {
    try {
      await _service.deleteFriend(friendId);
    } catch (error) {
      throw StateError('친구를 삭제하지 못했어요. $error');
    }
  }
}
