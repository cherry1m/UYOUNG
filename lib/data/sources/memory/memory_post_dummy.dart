import 'package:uyoung/data/model/memory/memory_post_model.dart';

class MemoryPostDummy {
  // MARK: - 기억섬 ID별 게시물 데이터
  static final Map<String, List<MemoryPostModel>> postsByMemoryId = {
    "1": _tokyoPosts(), // 일본팸
    "2": _shankongPosts(),
    "3": _dolphinPosts(),
    // "4": _kalchae(),
    "5": _couplePosts(),
    "6": _alcholPosts(),
    "7": _europe(),
  };

  // MARK: - 일본팸 게시물
  static List<MemoryPostModel> _tokyoPosts() {
    return [
      // 12월 7일
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 7일",
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
        createdAt: "12월 7일",
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
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 7일",
        images: [
          "assets/images/memory/japan/tokyo27.png",
          "assets/images/memory/japan/tokyo28.png",
          "assets/images/memory/japan/tokyo22.png",
        ],
      ),

      // 12월 6일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 6일",
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
        createdAt: "12월 6일",
        images: [
          "assets/images/memory/japan/tokyo9.png",
          "assets/images/memory/japan/tokyo8.png",
          "assets/images/memory/japan/tokyo18.png",
          "assets/images/memory/japan/tokyo4.png",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 6일",
        images: [
          "assets/images/memory/japan/hukuoka4.png",
          "assets/images/memory/japan/hukuoka5.png",
          "assets/images/memory/japan/hukuoka6.png",
          "assets/images/memory/japan/hukuoka7.png",
          "assets/images/memory/japan/hukuoka14.png",
          "assets/images/memory/japan/hukuoka18.png",
        ],
      ),

      // 12월 5일
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 5일",
        images: [
          "assets/images/memory/japan/tokyo1.png",
          "assets/images/memory/japan/tokyo10.png",
          "assets/images/memory/japan/tokyo16.png",
        ],
      ),

      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 5일",
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
        profileImage: "assets/images/choi_profile.png",
        createdAt: "12월 5일",
        images: [
          "assets/images/memory/japan/hukuoka19.png",
          "assets/images/memory/japan/hukuoka20.png",
          "assets/images/memory/japan/hukuoka21.png",
          "assets/images/memory/japan/hukuoka22.png",
        ],
      ),
    ];
  }

  // MARK: - 상콩즈 게시물
  static List<MemoryPostModel> _shankongPosts() {
    return [
      // 12월 13일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 13일",
        images: [
          "assets/images/memory/shangkong/pic1.jpeg",
          "assets/images/memory/shangkong/pic2.jpeg",
          "assets/images/memory/shangkong/pic3.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 13일",
        images: [
          "assets/images/memory/shangkong/hongkong16.jpeg",
          "assets/images/memory/shangkong/hongkong17.jpeg",
          "assets/images/memory/shangkong/hongkong18.jpeg",
          "assets/images/memory/shangkong/hongkong19.jpeg",
          "assets/images/memory/shangkong/hongkong20.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 13일",
        images: [
          "assets/images/memory/shangkong/hongkong21.jpeg",
          "assets/images/memory/shangkong/hongkong22.jpeg",
          "assets/images/memory/shangkong/hongkong23.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 13일",
        images: [
          "assets/images/memory/shangkong/hongkong24.jpeg",
          "assets/images/memory/shangkong/hongkong25.jpeg",
          "assets/images/memory/shangkong/hongkong26.jpeg",
        ],
      ),

      // 12월 12일
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 12일",
        images: [
          "assets/images/memory/shangkong/hongkong27.jpeg",
          "assets/images/memory/shangkong/hongkong28.jpeg",
          "assets/images/memory/shangkong/hongkong29.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 12일",
        images: [
          "assets/images/memory/shangkong/hongkong30.jpeg",
          "assets/images/memory/shangkong/hongkong31.jpeg",
          "assets/images/memory/shangkong/hongkong32.jpeg",
          "assets/images/memory/shangkong/hongkong33.jpeg",
          "assets/images/memory/shangkong/hongkong34.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 12일",
        images: [
          "assets/images/memory/shangkong/shanghi1.jpeg",
          "assets/images/memory/shangkong/shanghi2.jpeg",
          "assets/images/memory/shangkong/shanghi3.jpeg",
          "assets/images/memory/shangkong/shanghi4.jpeg",
          "assets/images/memory/shangkong/shanghi5.jpeg",
          "assets/images/memory/shangkong/shanghi6.jpeg",
        ],
      ),

      // 12월 11일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 11일",
        images: [
          "assets/images/memory/shangkong/shanghi7.jpeg",
          "assets/images/memory/shangkong/shanghi8.jpeg",
          "assets/images/memory/shangkong/shanghi9.jpeg",
          "assets/images/memory/shangkong/shanghi10.jpeg",
          "assets/images/memory/shangkong/shanghi11.jpeg",
          "assets/images/memory/shangkong/shanghi12.jpeg",
          "assets/images/memory/shangkong/shanghi13.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 11일",
        images: [
          "assets/images/memory/shangkong/hongkong1.jpeg",
          "assets/images/memory/shangkong/hongkong2.jpeg",
          "assets/images/memory/shangkong/hongkong3.jpeg",
          "assets/images/memory/shangkong/hongkong4.jpeg",
          "assets/images/memory/shangkong/hongkong5.jpeg",
          "assets/images/memory/shangkong/hongkong6.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 11일",
        images: [
          "assets/images/memory/shangkong/hongkong7.jpeg",
          "assets/images/memory/shangkong/hongkong8.jpeg",
          "assets/images/memory/shangkong/hongkong9.jpeg",
          "assets/images/memory/shangkong/hongkong10.jpeg",
          "assets/images/memory/shangkong/hongkong11.jpeg",
          "assets/images/memory/shangkong/hongkong12.jpeg",
        ],
      ),

      // 12월 10일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 10일",
        images: [
          "assets/images/memory/shangkong/hongkong13.jpeg",
          "assets/images/memory/shangkong/hongkong14.jpeg",
          "assets/images/memory/shangkong/hongkong15.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 10일",
        images: [
          "assets/images/memory/shangkong/hongkong35.jpeg",
          "assets/images/memory/shangkong/hongkong36.jpeg",
          "assets/images/memory/shangkong/hongkong37.jpeg",
          "assets/images/memory/shangkong/hongkong38.jpeg",
          "assets/images/memory/shangkong/hongkong39.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 10일",
        images: [
          "assets/images/memory/shangkong/hongkong40.jpeg",
          "assets/images/memory/shangkong/hongkong41.jpeg",
          "assets/images/memory/shangkong/hongkong42.jpeg",
          "assets/images/memory/shangkong/hongkong43.jpeg",
        ],
      ),
    ];
  }

  // MARK: - 물개 달란트 게시물
  static List<MemoryPostModel> _dolphinPosts() {
    return [
      // 12월 19일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 19일",
        images: [
          "assets/images/memory/dolphin/guam1.jpeg",
          "assets/images/memory/dolphin/guam2.jpeg",
          "assets/images/memory/dolphin/guam3.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 19일",
        images: [
          "assets/images/memory/dolphin/guam4.jpeg",
          "assets/images/memory/dolphin/guam5.jpeg",
          "assets/images/memory/dolphin/guam6.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 19일",
        images: [
          "assets/images/memory/dolphin/guam7.jpeg",
          "assets/images/memory/dolphin/guam8.jpeg",
          "assets/images/memory/dolphin/guam9.jpeg",
          "assets/images/memory/dolphin/guam10.jpeg",
        ],
      ),

      // 12월 17일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 17일",
        images: [
          "assets/images/memory/dolphin/guam11.jpeg",
          "assets/images/memory/dolphin/guam12.jpeg",
          "assets/images/memory/dolphin/guam13.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 17일",
        images: [
          "assets/images/memory/dolphin/vietnam1.jpeg",
          "assets/images/memory/dolphin/vietnam2.jpeg",
          "assets/images/memory/dolphin/vietnam3.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 17일",
        images: [
          "assets/images/memory/dolphin/vietnam4.jpeg",
          "assets/images/memory/dolphin/vietnam5.jpeg",
        ],
      ),
    ];
  }

  // MARK: - 커플 게시물
  static List<MemoryPostModel> _couplePosts() {
    return [
      // 12월 24일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 24일",
        images: [
          "assets/images/memory/couple/couple1.jpeg",
          "assets/images/memory/couple/couple2.JPG",
          "assets/images/memory/couple/couple3.JPG",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 24일",
        images: [
          "assets/images/memory/couple/couple4.jpeg",
          "assets/images/memory/couple/couple5.JPG",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 24일",
        images: [
          "assets/images/memory/couple/couple6.jpeg",
          "assets/images/memory/couple/couple7.jpeg",
        ],
      ),

      // 12월 22일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 22일",
        images: [
          "assets/images/memory/couple/couple8.jpeg",
          "assets/images/memory/couple/couple9.png",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 22일",
        images: [
          "assets/images/memory/couple/couple10.jpeg",
          "assets/images/memory/couple/couple11.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 22일",
        images: ["assets/images/memory/couple/couple12.png"],
      ),

      // 12월 20일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 20일",
        images: [
          "assets/images/memory/couple/couple13.jpg",
          "assets/images/memory/couple/couple14.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 20일",
        images: [
          "assets/images/memory/couple/couple15.jpeg",
          "assets/images/memory/couple/couple16.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 20일",
        images: [
          "assets/images/memory/couple/couple17.jpeg",
          "assets/images/memory/couple/couple18.jpeg",
          "assets/images/memory/couple/couple19.png",
        ],
      ),
    ];
  }

  // MARK: - 술독 게시물
  static List<MemoryPostModel> _alcholPosts() {
    return [
      // 12월 27일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 27일",
        images: [
          "assets/images/memory/alcohol/alcohol2.jpeg",
          "assets/images/memory/alcohol/alcohol3.jpeg",
          "assets/images/memory/alcohol/alcohol4.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 27일",
        images: [
          "assets/images/memory/alcohol/alcohol5.jpeg",
          "assets/images/memory/alcohol/alcohol6.jpeg",
          "assets/images/memory/alcohol/alcohol7.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 27일",
        images: [
          "assets/images/memory/alcohol/alcohol8.jpeg",
          "assets/images/memory/alcohol/alcohol9.jpeg",
        ],
      ),

      // 12월 26일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 26일",
        images: ["assets/images/memory/alcohol/alcohol10.jpeg"],
      ),
      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/choi_profile.png",
        createdAt: "12월 26일",
        images: [
          "assets/images/memory/alcohol/alcohol11.png",
          "assets/images/memory/alcohol/alcohol12.png",
          "assets/images/memory/alcohol/alcohol13.png",
          "assets/images/memory/alcohol/alcohol14.png",
        ],
      ),
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 26일",
        images: ["assets/images/memory/alcohol/alcohol15.jpeg"],
      ),

      // 12월 24일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 24일",
        images: ["assets/images/memory/alcohol/alcohol16.jpeg"],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 24일",
        images: ["assets/images/memory/alcohol/alcohol17.jpeg"],
      ),
    ];
  }

  // MARK: - 유러피안 게시물
  static List<MemoryPostModel> _europe() {
    return [
      // 12월 31일
      MemoryPostModel(
        name: "윤채림",
        profileImage: "assets/images/yoon_profile.png",
        createdAt: "12월 31일",
        images: [
          "assets/images/memory/europe/h1.jpeg",
          "assets/images/memory/europe/h2.jpeg",
          "assets/images/memory/europe/h3.jpeg",
          "assets/images/memory/europe/h4.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/choi_profile.png",
        createdAt: "12월 31일",
        images: [
          "assets/images/memory/europe/h5.jpeg",
          "assets/images/memory/europe/h6.jpeg",
          "assets/images/memory/europe/h7.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "최보빈",
        profileImage: "assets/images/choi_profile.png",
        createdAt: "12월 31일",
        images: [
          "assets/images/memory/europe/c1.jpeg",
          "assets/images/memory/europe/c2.jpeg",
          "assets/images/memory/europe/c3.jpeg",
          "assets/images/memory/europe/c4.jpeg",
        ],
      ),

      // 12월 30일
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 30일",
        images: [
          "assets/images/memory/europe/c5.jpeg",
          "assets/images/memory/europe/c6.jpeg",
          "assets/images/memory/europe/c7.jpeg",
          "assets/images/memory/europe/c8.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "조성은",
        profileImage: "assets/images/cho_profile.png",
        createdAt: "12월 30일",
        images: [
          "assets/images/memory/europe/c9.jpeg",
          "assets/images/memory/europe/c10.jpeg",
          "assets/images/memory/europe/c11.jpeg",
          "assets/images/memory/europe/c12.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 30일",
        images: [
          "assets/images/memory/europe/c13.jpeg",
          "assets/images/memory/europe/c14.jpeg",
        ],
      ),

      // 12월 29일
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 29일",
        images: [
          "assets/images/memory/europe/ger1.jpeg",
          "assets/images/memory/europe/ger2.jpeg",
          "assets/images/memory/europe/ger3.jpeg",
          "assets/images/memory/europe/ger4.jpeg",
          "assets/images/memory/europe/ger5.jpeg",
        ],
      ),
      MemoryPostModel(
        name: "이윤서",
        profileImage: "assets/images/lee_profile.png",
        createdAt: "12월 29일",
        images: [
          "assets/images/memory/europe/o1.jpeg",
          "assets/images/memory/europe/o2.jpeg",
          "assets/images/memory/europe/o3.jpeg",
        ],
      ),
    ];
  }
}
