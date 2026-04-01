import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/home/attend_check_page.dart';
import 'package:uyoung/src/viewModel/home/pearl_view_model.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final PearlViewModel _pearlViewModel;

  @override
  void initState() {
    super.initState();
    _pearlViewModel = PearlViewModel()..load();
  }

  @override
  void dispose() {
    _pearlViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: _pearlViewModel,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Image.asset(
                    ImagePath.storePage,
                    width: screenWidth,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              _pearlBox(context),
              _saveButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _pearlBox(BuildContext context) {
    final pearlVm = context.watch<PearlViewModel>();

    return Positioned(
      top: 60,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AttendCheckPage()),
          );
        },
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

  Widget _saveButton(BuildContext context) {
    return Positioned(
      top: 68,
      right: 20,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('저장 기능은 준비 중이에요.')),
            );
        },
        child: Text(
          '저장하기',
          style: AppFontStyle.S8.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
