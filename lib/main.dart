import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/src/view/pages/login/login_main_page.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 날짜 포맷 초기화
  await initializeDateFormatting('ko_KR', null);

  // 필요 시 안전 대기
  await Future.delayed(const Duration(milliseconds: 300));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryViewModel()..load()),
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
      locale: Locale('ko', 'KR'),
      supportedLocales: [Locale('ko', 'KR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ✅ feat/login 브랜치에서는 로그인 화면부터 시작
      home: LoginMainPage(),
    );
  }
}
