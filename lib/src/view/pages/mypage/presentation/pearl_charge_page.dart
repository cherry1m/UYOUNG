import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';

class PearlChargePage extends StatelessWidget {
  const PearlChargePage({super.key});

  static final List<_PearlPackage> _packages = [
    _PearlPackage(
      title: '진주 한줌',
      countLabel: '10개',
      priceLabel: '1,000',
      imagePath: ImagePath.pearl10,
      imageSize: Size(44, 44),
    ),
    _PearlPackage(
      title: '진주 꾸러미',
      countLabel: '50개',
      priceLabel: '4,800',
      imagePath: ImagePath.pearl50,
      imageSize: Size(46, 46),
    ),
    _PearlPackage(
      title: '진주 상자',
      countLabel: '100개',
      priceLabel: '9,500',
      imagePath: ImagePath.pearl100,
      imageSize: Size(44, 44),
    ),
    _PearlPackage(
      title: '진주 보물함',
      countLabel: '200개',
      priceLabel: '18,800',
      imagePath: ImagePath.pearl200,
      imageSize: Size(50, 50),
    ),
    _PearlPackage(
      title: '진주 창고',
      countLabel: '300개',
      priceLabel: '26,900',
      imagePath: ImagePath.pearl300,
      imageSize: Size(42, 42),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '충전소',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          itemBuilder: (context, index) {
            final item = _packages[index];
            return _PearlPackageCard(item: item);
          },
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemCount: _packages.length,
        ),
      ),
    );
  }
}

class _PearlPackageCard extends StatelessWidget {
  final _PearlPackage item;

  const _PearlPackageCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8ED)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Image.asset(
                item.imagePath,
                width: item.imageSize.width,
                height: item.imageSize.height,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppFontStyle.H8.copyWith(
                    color: const Color(0xFF6A6A6A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.countLabel,
                  style: AppFontStyle.H7.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item.priceLabel,
            style: AppFontStyle.H6.copyWith(color: const Color(0xFF4B4B4B)),
          ),
        ],
      ),
    );
  }
}

class _PearlPackage {
  final String title;
  final String countLabel;
  final String priceLabel;
  final String imagePath;
  final Size imageSize;

  _PearlPackage({
    required this.title,
    required this.countLabel,
    required this.priceLabel,
    required this.imagePath,
    required this.imageSize,
  });
}
