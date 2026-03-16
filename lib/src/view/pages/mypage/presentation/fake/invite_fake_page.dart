import 'package:flutter/material.dart';

class InviteFakePage extends StatelessWidget {
  const InviteFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Image.asset(
            'assets/images/invite_friend.png',
            width: w,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
