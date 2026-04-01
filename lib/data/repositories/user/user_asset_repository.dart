import 'package:uyoung/data/model/user/user_asset_model.dart';
import 'package:uyoung/data/sources/supabase/user/user_asset_service.dart';

class UserAssetRepository {
  UserAssetRepository({UserAssetService? service})
    : _service = service ?? UserAssetService();

  final UserAssetService _service;

  Future<UserAsset> fetchUserAsset() async {
    try {
      return await _service.fetchUserAsset();
    } catch (error) {
      throw StateError('진주 정보를 불러오지 못했어요. $error');
    }
  }
}
