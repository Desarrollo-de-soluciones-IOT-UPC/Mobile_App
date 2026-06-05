import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'screens/etapa1/screen_7_pair_your_sensor.dart';



void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EmSafe',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.splash1,
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.pairYourSensor) {
          return PageRouteBuilder(
            settings: settings,
            opaque: false, // Mantiene viva la pantalla anterior debajo
            pageBuilder: (context, _, __) => const PairYourSensorScreen(),
          );
        }

        // Fallback: deja que MaterialApp resuelva con los routes existentes.
        return null;
      },
    );
  }
}

  