class FrameContent {
  final String image;
  final String title;
  final String actionText;
  final String profileImage;
  final String name;

  const FrameContent({
    required this.image,
    required this.title,
    required this.actionText,
    required this.profileImage,
    required this.name,
  });
}

const List<FrameContent> todayShellFrameContents = [
  FrameContent(
    image: "assets/images/shell_story_seaotter.png",
    title: "조개 이야기를 사진으로 채워볼까요?",
    actionText: "사진 추가하기 >",
    profileImage: "assets/images/lee_profile.png",
    name: "이윤서",
  ),
  FrameContent(
    image: "assets/images/open_shell_story.png",
    title: "아직 닫혀 있는 조개가 남아있어요",
    actionText: "친구에게 열어달라고 말해 볼까요?",
    profileImage: "assets/images/yoon_profile.png",
    name: "윤채림",
  ),
  FrameContent(
    image: "assets/images/open_shell_story.png",

    title: "아직 닫혀 있는 조개가 남아있어요",
    actionText: "친구에게 열어달라고 말해 볼까요?",
    profileImage: "assets/images/cho_profile.png",
    name: "조성은",
  ),
  FrameContent(
    image: "assets/images/open_shell_story.png",

    title: "아직 닫혀 있는 조개가 남아있어요",
    actionText: "친구에게 열어달라고 말해 볼까요?",
    profileImage: "assets/images/choi_profile.png",
    name: "최보빈",
  ),
];
