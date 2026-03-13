import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';
import 'package:uyoung/src/view/pages/login/login_main_page.dart';
import 'package:uyoung/src/view/pages/memory/invite_island_page.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 날짜 포맷 초기화
  await initializeDateFormatting('ko_KR', null);

  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(url: SupabaseConfig.url, anonKey: SupabaseConfig.anonKey);
  }

  // 필요 시 안전 대기
  await Future.delayed(const Duration(milliseconds: 300));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => MemoryViewModel()..load()),
        ChangeNotifierProvider(create: (_) => CalendarViewModel()),
      ],
      child: const UyoungRoot(),
    ),
  );
}

class UyoungRoot extends StatefulWidget {
  const UyoungRoot({super.key});

  @override
  State<UyoungRoot> createState() => _UyoungRootState();
}

class _UyoungRootState extends State<UyoungRoot> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  final Set<String> _handledInviteCodes = <String>{};

  @override
  void initState() {
    super.initState();
    _listenInitialLink();
    _linkSubscription = _appLinks.uriLinkStream.listen(_handleUri);
  }

  Future<void> _listenInitialLink() async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _handleUri(uri);
    }
  }

  void _handleUri(Uri uri) {
    debugPrint('[deeplink] received: $uri');
    if (_isAuthCallback(uri)) {
      debugPrint('[deeplink] auth callback received');
      return;
    }

    final inviteCode = _extractInviteCode(uri);
    if (inviteCode == null || _handledInviteCodes.contains(inviteCode)) {
      return;
    }

    _handledInviteCodes.add(inviteCode);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = _navigatorKey.currentState;
      if (navigator == null) {
        return;
      }
      navigator.push(
        MaterialPageRoute(
          builder: (_) => InviteIslandPage(inviteCode: inviteCode),
        ),
      );
    });
  }

  String? _extractInviteCode(Uri uri) {
    final queryCode = uri.queryParameters['code'];
    if (queryCode != null && queryCode.isNotEmpty) {
      return queryCode;
    }

    final segments = uri.pathSegments;
    if (segments.length >= 2 && segments.first == 'invite') {
      return segments[1];
    }

    if (segments.isNotEmpty && segments.last.isNotEmpty) {
      return segments.last;
    }

    return null;
  }

  bool _isAuthCallback(Uri uri) {
    return uri.host == 'login-callback' ||
        uri.pathSegments.contains('login-callback');
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Supabase.instance.client.auth;

    return StreamBuilder<AuthState>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        final event = snapshot.data?.event;
        final session = snapshot.data?.session ?? auth.currentSession;
        debugPrint(
          '[auth] event=$event session=${session != null} user=${session?.user.email ?? auth.currentUser?.email}',
        );
        if (session == null) {
          return const LoginMainPage();
        }

        return const UyoungApp();
      },
    );
  }
}
