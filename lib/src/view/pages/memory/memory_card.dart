import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class MemoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final bool isFavorite;
  final bool isNotificationOn;
  final List<MemoryMemberPreview> members;
  final bool isEditing;
  final TextEditingController controller;
  final VoidCallback onEditComplete;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const MemoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isFavorite,
    required this.isNotificationOn,
    required this.members,
    required this.isEditing,
    required this.controller,
    required this.onEditComplete,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/memory_frame.png",
                    fit: BoxFit.fill,
                  ),
                ),
                if (imagePath != null)
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _buildImage(),
                      ),
                    ),
                  ),
                if (!isNotificationOn)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: _badgeIcon(
                      Icons.volume_off_rounded,
                      backgroundColor: Colors.black.withOpacity(0.56),
                    ),
                  ),
                if (isFavorite)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _badgeIcon(
                      Icons.star_rounded,
                      backgroundColor: const Color(0xFFFFC83D),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: isEditing ? 32 : 36,
            child: isEditing
                ? TextField(
                    controller: controller,
                    autofocus: true,
                    onSubmitted: (_) => onEditComplete(),
                    style: AppFontStyle.M_16,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFontStyle.M_16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Expanded(child: _memberPreviewRow()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath == null || imagePath!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (imagePath!.startsWith('http://') || imagePath!.startsWith('https://')) {
      return Image.network(imagePath!, fit: BoxFit.cover);
    }

    return Image.asset(imagePath!, fit: BoxFit.cover);
  }

  Widget _badgeIcon(
    IconData icon, {
    required Color backgroundColor,
  }) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }

  Widget _memberPreviewRow() {
    if (members.isEmpty) {
      return const SizedBox.expand();
    }

    final visibleMembers = members.take(3).toList();

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 18,
        child: Stack(
          children: [
            for (int index = 0; index < visibleMembers.length; index++)
              Positioned(
                left: index * 12,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.4),
                    color: const Color(0xFFE6E6E6),
                  ),
                  child: ClipOval(
                    child: visibleMembers[index].avatarUrl?.isNotEmpty == true
                        ? Image.network(
                            visibleMembers[index].avatarUrl!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              visibleMembers[index].nickname.isEmpty
                                  ? '?'
                                  : visibleMembers[index].nickname[0],
                              style: AppFontStyle.M_10.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
