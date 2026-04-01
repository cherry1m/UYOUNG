import 'package:uyoung/data/model/home/attendance_result_model.dart';
import 'package:uyoung/data/sources/supabase/home/attendance_service.dart';
import 'package:uyoung/data/sources/supabase/user/user_asset_service.dart';

class AttendanceRepository {
  final AttendanceService _attendanceService;
  final UserAssetService _userAssetService;

  AttendanceRepository({
    AttendanceService? attendanceService,
    UserAssetService? userAssetService,
  }) : _attendanceService = attendanceService ?? AttendanceService(),
       _userAssetService = userAssetService ?? UserAssetService();

  Future<AttendanceResult> checkInAndDraw() async {
    try {
      return await _attendanceService.checkInAndDraw();
    } catch (error) {
      throw StateError('출석 체크에 실패했어요. $error');
    }
  }

  Future<int> fetchPearlCount() async {
    try {
      final asset = await _userAssetService.fetchUserAsset();
      return asset.pearlCount;
    } catch (error) {
      throw StateError('진주 개수를 불러오지 못했어요. $error');
    }
  }
}
