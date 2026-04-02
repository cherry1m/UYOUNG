import 'package:flutter/material.dart';
import 'package:uyoung/data/model/home/attendance_result_model.dart';
import 'package:uyoung/data/repositories/home/attendance_repository.dart';

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository _repository;

  AttendanceViewModel({AttendanceRepository? repository})
    : _repository = repository ?? AttendanceRepository();

  AttendanceResult? _result;
  bool _isLoading = false;
  String? _errorMessage;
  int _pearlCount = 0;

  AttendanceResult? get result => _result;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get pearlCount => _pearlCount;

  bool get hasResult => _result != null;
  bool get isAlreadyChecked => _result?.isAlreadyChecked == true;
  bool get isSuccess => _result?.isSuccess == true;
  int get streak => _result?.streak ?? 0;

  String get summaryTitle {
    if (_isLoading) {
      return '오늘의 선물을 확인하고 있어요...';
    }

    if (_errorMessage != null) {
      return '출석 처리 중 문제가 생겼어요';
    }

    if (_result == null) {
      return '해달이 무언가를 밑에서 가져오려 해요';
    }

    if (_result!.isAlreadyChecked) {
      return '오늘 출석은 이미 완료했어요';
    }

    if (_result!.isWin) {
      final rewardLabel = _result!.rewardLabel;
      final rewardCount = _result!.rewardCount;
      if (rewardCount > 0) {
        return '오늘은 진주 $rewardCount개를 받았어요!';
      }
      return rewardLabel.isNotEmpty
          ? '오늘은 ${_displayRewardLabel(rewardLabel)}을 받았어요!'
          : '오늘은 진주를 받았어요!';
    }

    return '오늘은 아쉽게 꽝이에요';
  }

  String get summaryBody {
    if (_isLoading) {
      return '잠시만 기다려주세요.';
    }

    if (_errorMessage != null) {
      return _errorMessage!;
    }

    if (_result == null) {
      return '오늘은 어떤 걸 주워올까요?';
    }

    if (_result!.isAlreadyChecked) {
      return '내일 다시 출석하고 새로운 보상을 받아보세요.';
    }

    if (_result!.isWin) {
      return '연속 출석 ${_result!.streak}일차예요.\n현재 보유 진주는 $_pearlCount개예요.';
    }

    return '연속 출석 ${_result!.streak}일차예요.\n다음 보상을 기대해봐요.';
  }

  String get actionLabel {
    if (_isLoading) {
      return '처리 중...';
    }

    if (_errorMessage != null) {
      return '다시 시도하기';
    }

    if (_result == null) {
      return '출석 체크하기';
    }

    return '확인했어요';
  }

  Future<void> checkIn() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.checkInAndDraw();
      _result = result;

      if (result.isSuccess) {
        _pearlCount = await _repository.fetchPearlCount();
      }
    } catch (error) {
      _errorMessage = error.toString().replaceFirst('StateError: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _displayRewardLabel(String rewardLabel) {
    return rewardLabel.replaceAll('등장!', '').replaceAll('등장', '').trim();
  }
}
