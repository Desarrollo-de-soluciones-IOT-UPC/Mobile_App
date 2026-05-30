import 'package:flutter/material.dart';

import '../../widgets/etapa1_splash_body.dart';

class SplashOfficialBrandScreen extends StatelessWidget {
  const SplashOfficialBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Etapa1SplashBody(
        onContinue: () {
          // Por ahora solo para demostrar interactividad del UI.
          // Cuando armemos el resto del onboarding, conectamos a la pantalla 2.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Continuar (UI)')),
          );
        },
      ),
    );
  }
}


