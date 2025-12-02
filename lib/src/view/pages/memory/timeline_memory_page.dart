import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

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
  // MARK: Google Map controller
  GoogleMapController? _mapController;

  // MARK: Default camera position
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.6280, 127.0905), // 노원구 예시 좌표
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MemoryViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: widget.item.title),

      // MARK: 화면 전체 레이아웃
      body: Column(
        children: [
          // MARK: 지도 영역
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),

          // MARK: 지도 하단 타임라인 콘텐츠
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MARK: 날짜 선택 영역
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // MARK: 이전 날짜 버튼
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.arrow_back_ios, size: 18),
                        ),

                        // MARK: 날짜 드롭다운 버튼
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text("오늘", style: AppFontStyle.M_18),
                              const Icon(Icons.keyboard_arrow_down, size: 22),
                            ],
                          ),
                        ),

                        // MARK: 다음 날짜 버튼
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // MARK: 위치 라벨 + 그리드 섹션 1
                  _locationLabel("서울특별시 노원구 월계2동"),
                  const SizedBox(height: 12),
                  _grayGrid(),

                  const SizedBox(height: 28),

                  // MARK: 위치 라벨 + 그리드 섹션 2
                  _locationLabel("서울특별시 중구 명동"),
                  const SizedBox(height: 12),
                  _grayGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: 위치 라벨 UI
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

  // MARK: 3x3 Gray Grid Placeholder
  Widget _grayGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
