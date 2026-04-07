import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/common/home/common_icon_bages.dart';
import 'package:uyoung/src/view/pages/home/attend_check_page.dart';
import 'package:uyoung/src/view/pages/home/notification_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/pearl_charge_page.dart';
import 'package:uyoung/src/viewModel/home/notification_view_model.dart';
import 'package:uyoung/src/viewModel/home/pearl_view_model.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  late final PearlViewModel _pearlViewModel;
  late final NotificationViewModel _notificationViewModel;

  @override
  void initState() {
    super.initState();
    _pearlViewModel = PearlViewModel()..load();
    _notificationViewModel = NotificationViewModel()..load();
  }

  @override
  void dispose() {
    _pearlViewModel.dispose();
    _notificationViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _pearlViewModel),
        ChangeNotifierProvider.value(value: _notificationViewModel),
      ],
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/home_main.png",
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -1.0),
                ),
              ),
              Positioned(
                left: 90,
                top: 342,
                child: Image.asset(
                  ImagePath.homeMyCharacter,
                  width: 211,
                  height: 224,
                  fit: BoxFit.contain,
                ),
              ),
              _pearlBox(context),
              _alert(context),
              _check(),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openPearlChargePage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PearlChargePage()),
    );
    await _pearlViewModel.load();
  }

  Future<void> _openNotificationPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotificationPage(viewModel: _notificationViewModel),
      ),
    );
    await _notificationViewModel.load();
  }

  Future<void> _openAttendCheckPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AttendCheckPage()),
    );
    await _pearlViewModel.load();
  }

  Widget _pearlBox(BuildContext context) {
    final pearlVm = context.watch<PearlViewModel>();

    return Positioned(
      top: 60,
      left: 20,
      child: GestureDetector(
        onTap: () => _openPearlChargePage(context),
        child: SizedBox(
          width: 82,
          height: 36,
          child: Stack(
            children: [
              const Image(
                image: AssetImage("assets/images/pearl_box.png"),
                width: 82,
                height: 36,
              ),
              Positioned(
                top: 12,
                left: 39,
                child: Text(
                  pearlVm.pearlCountLabel,
                  style: AppFontStyle.H8.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //MARK: - 상단 알림 아이콘
  Widget _alert(BuildContext context) {
    final notificationVm = context.watch<NotificationViewModel>();

    return Positioned(
      top: 60,
      right: 15,
      child: GestureDetector(
        onTap: () => _openNotificationPage(context),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Image(
              image: AssetImage("assets/images/alert.png"),
              width: 28,
              height: 30,
            ),
            if (notificationVm.hasUnread)
              const Positioned(
                top: -2,
                right: -4,
                child: _UnreadDot(),
              ),
          ],
        ),
      ),
    );
  }

  // MARK: - 출석 체크 아이콘
  Widget _check() {
    return Builder(
      builder: (context) {
        return CommonIconBages(
          left: 20,
          top: 106,
          imagePath: "assets/images/pearl_shell.png",
          imageSize: 35,
          title: "출석 체크",
          onTap: () => _openAttendCheckPage(context),
        );
      },
    );
  }
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xFFFF4D4F),
        shape: BoxShape.circle,
      ),
    );
  }
}
