import 'package:uyoung/data/model/memory/memory_item_model.dart';

class IslandInviteDetail {
  final String islandId;
  final String name;
  final String? bgImageUrl;
  final String inviteCode;
  final List<MemoryMemberPreview> members;

  const IslandInviteDetail({
    required this.islandId,
    required this.name,
    required this.inviteCode,
    this.bgImageUrl,
    this.members = const [],
  });

  MemoryItem toMemoryItem() {
    return MemoryItem(
      id: islandId,
      title: name,
      isFavorite: false,
      isNotificationOn: true,
      imagePath: bgImageUrl,
      members: members,
      inviteCode: inviteCode,
    );
  }
}
