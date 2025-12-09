import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class TimelineMemoryPage extends StatefulWidget {
  final MemoryItem item;

  const TimelineMemoryPage({
    super.key,
    required this.item,
    required String title,
  });

  @override
  State<TimelineMemoryPage> createState() => _TimelineMemoryPageState();
}

class _TimelineMemoryPageState extends State<TimelineMemoryPage> {
  GoogleMapController? _mapController;

  // MARK: 도쿄 고정 위치
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6595, 139.7005),
    zoom: 13,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("tokyo"),
      position: LatLng(35.6595, 139.7005),
    ),
  };

  @override
  Widget build(BuildContext context) {
    // MARK: 기억섬 ID로 게시물 불러오기
    final List<MemoryPostModel> posts =
        MemoryPostDummy.postsByMemoryId[widget.item.id] ?? [];

    // MARK: 모든 게시물 이미지 일자로 쭉 펼치기
    final List<String> allImages = posts.expand((post) => post.images).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: widget.item.title),

      body: Column(
        children: [
          // MARK: 지도
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              zoomControlsEnabled: false,
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),

          // MARK: 하단 타임라인 영역
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  _locationLabel("일본 도쿄"),

                  const SizedBox(height: 12),

                  // MARK: 더미 이미지 실제 그리드
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemBuilder: (_, index) {
                      return _photoItem(allImages[index]);
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: 위치 라벨
  Widget _locationLabel(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          const CircleAvatar(radius: 4, backgroundColor: Color(0xFFAFAFAF)),
          const SizedBox(width: 6),
          Text(title, style: AppFontStyle.M_14),
        ],
      ),
    );
  }

  // MARK: 실제 이미지 박스
  Widget _photoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
}
