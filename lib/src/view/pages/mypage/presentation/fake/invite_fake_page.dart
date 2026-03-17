import 'package:flutter/material.dart';
import 'package:uyoung/data/image_data.dart';

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
            ImagePath.inviteFriend,
            width: w,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
