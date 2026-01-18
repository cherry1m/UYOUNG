import 'package:flutter/material.dart';

class PearFakePage extends StatelessWidget {
  const PearFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Image.asset(
            'assets/images/pear_charge.png',
            width: w,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
