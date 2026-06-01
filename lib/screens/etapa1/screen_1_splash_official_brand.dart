import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/etapa1_splash_body.dart';

class SplashOfficialBrandScreen extends StatelessWidget {
  const SplashOfficialBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Etapa1SplashBody(
        onContinue: () {
          Navigator.of(context).pushNamed(AppRoutes.onboardingSmartAlerts);
        },
      ),
    );
  }
}



