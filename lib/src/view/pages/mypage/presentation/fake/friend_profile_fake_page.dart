import 'package:flutter/material.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/friend_profile_page.dart';

class FriendProfileFakePage extends StatelessWidget {
  const FriendProfileFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FriendProfilePage(
      name: '이윤서',
      imagePath: ImagePath.friendProfile,
    );
  }
}
