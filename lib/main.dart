import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'routes/etapa2_routes.dart';
import 'services/onboarding_flow_store.dart';
import 'theme/app_theme.dart';
import 'screens/etapa1/screen_7_pair_your_sensor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await OnboardingFlowStore.hasCreatedAccount()
      ? Etapa2Routes.login
      : AppRoutes.splash1;
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute = AppRoutes.splash1});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EmSafe',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.pairYourSensor) {
          return PageRouteBuilder(
            settings: settings,
            opaque: false, // Mantiene viva la pantalla anterior debajo
            pageBuilder: (context, _, _) => const PairYourSensorScreen(),
          );
        }

        // Fallback: deja que MaterialApp resuelva con los routes existentes.
        return null;
      },
    );
  }
}
