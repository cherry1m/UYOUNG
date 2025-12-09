import 'package:uyoung/data/model/memory/memory_post_model.dart';

class MemoryPostDummy {
  // MARK: - 기억섬 ID별 게시물 데이터
  static final Map<String, List<MemoryPostModel>> postsByMemoryId = {
    "1": _tokyoPosts(), // 일본팸
    // "2": _sangongPosts(),
    // "3": _waterSealPosts(),
  };

  // MARK: - 일본팸 게시물
  static List<MemoryPostModel> _tokyoPosts() {
    return [
      // 게시물 1 (사진 4장)
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/tokyo7.png",
          "assets/images/memory/japan/tokyo3.png",
          "assets/images/memory/japan/tokyo2.png",
          "assets/images/memory/japan/tokyo5.png",
          "assets/images/memory/japan/tokyo20.png",
          "assets/images/memory/japan/tokyo21.png",
        ],
      ),
      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/choi_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/tokyo11.png",
          "assets/images/memory/japan/tokyo12.png",
          "assets/images/memory/japan/tokyo17.png",
          "assets/images/memory/japan/tokyo14.png",
          "assets/images/memory/japan/tokyo13.png",
          "assets/images/memory/japan/tokyo5.png",
          "assets/images/memory/japan/tokyo6.png",
        ],
      ),

      MemoryPostModel(
        name: "성지현",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/tokyo27.png",
          "assets/images/memory/japan/tokyo28.png",
          "assets/images/memory/japan/tokyo22.png",
        ],
      ),
      MemoryPostModel(
        name: "김아인",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/Sapporo5.png",
          "assets/images/memory/japan/Sapporo3.png",
          "assets/images/memory/japan/Sapporo9.png",
          "assets/images/memory/japan/Sapporo13.jpeg",
          "assets/images/memory/japan/Sapporo8.png",
        ],
      ),
      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/choi_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/tokyo9.png",
          "assets/images/memory/japan/tokyo8.png",
          "assets/images/memory/japan/tokyo18.png",
          "assets/images/memory/japan/tokyo4.png",
        ],
      ),
      MemoryPostModel(
        name: "김아인",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/hukuoka4.png",
          "assets/images/memory/japan/hukuoka5.png",
          "assets/images/memory/japan/hukuoka6.png",
          "assets/images/memory/japan/hukuoka7.png",
          "assets/images/memory/japan/hukuoka14.png",
          "assets/images/memory/japan/hukuoka18.png",
        ],
      ),

      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/tokyo1.png",
          "assets/images/memory/japan/tokyo10.png",
          "assets/images/memory/japan/tokyo16.png",
        ],
      ),

      MemoryPostModel(
        name: "김아인",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/hukuoka2.png",
          "assets/images/memory/japan/hukuoka3.png",
          "assets/images/memory/japan/hukuoka9.png",
          "assets/images/memory/japan/hukuoka10.png",
          "assets/images/memory/japan/hukuoka21.png",
        ],
      ),

      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "1시간 전",
        images: [
          "assets/images/memory/japan/hukuoka19.png",
          "assets/images/memory/japan/hukuoka20.png",
          "assets/images/memory/japan/hukuoka21.png",
          "assets/images/memory/japan/hukuoka22.png",
        ],
      ),
    ];
  }
}
