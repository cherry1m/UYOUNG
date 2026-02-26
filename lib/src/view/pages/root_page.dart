import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/app.dart';

import 'package:uyoung/src/view/pages/login/login_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      return const UyoungApp();
    } else {
      return const LoginPage();
    }
  }
}
