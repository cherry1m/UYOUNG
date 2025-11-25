import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 추가!
  await Future.delayed(Duration(milliseconds: 300)); // 안전 대기 (필요)
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryViewModel()..load()),
      ],
      child: const UyoungApp(),
    ),
  );
}

class UyoungApp extends StatelessWidget {
  const UyoungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MemoryMainPage(),
    );
  }
}
