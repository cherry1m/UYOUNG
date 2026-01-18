import 'package:flutter/material.dart';

class InviteFakePage extends StatelessWidget {
  const InviteFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Image.asset(
            'assets/images/invite_friend.png',

            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
