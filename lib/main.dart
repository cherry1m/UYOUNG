import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null); // 🔥 이거 중요

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryViewModel()),
        ChangeNotifierProvider(create: (_) => CalendarViewModel()),
      ],
      child: const UyoungRoot(),
    ),
  );
}

class UyoungRoot extends StatelessWidget {
  const UyoungRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const UyoungApp(),
    );
  }
}
