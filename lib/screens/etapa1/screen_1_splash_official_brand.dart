import 'package:flutter/material.dart';

class SplashOfficialBrandScreen extends StatelessWidget {
  const SplashOfficialBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/etapa_1_figma/1.Splash Screen - Official Brand.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

