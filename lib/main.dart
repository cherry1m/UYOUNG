import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MemoryViewModel())],
      child: const UyoungRoot(),
    ),
  );
}

class UyoungRoot extends StatelessWidget {
  const UyoungRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UyoungApp(), // 실제 앱 전체 구조
    );
  }
}
