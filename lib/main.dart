import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MemoryViewModel())],
      child: const UyoungApp(),
    ),
  );
}

class UyoungApp extends StatelessWidget {
  const UyoungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MemoryMainPage(),
    );
  }
}
