import 'package:flutter/material.dart';

import 'core/app_i18n.dart';
import 'core/app_navigator.dart';
import 'core/app_settings_store.dart';
import 'core/app_theme.dart';
import 'core/onboarding_flow_store.dart';
import 'core/session_store.dart';
import 'presentation/home/widgets/danger_alert_gate.dart';
import 'presentation/onboarding/screen_7_pair_your_sensor.dart';
import 'routes/app_routes.dart';
import 'routes/auth_routes.dart';
import 'routes/home_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSettingsStore.init();
  I18n.init();

  // Already authenticated → go straight to the dashboard.
  // Otherwise: returning user (account created) → login; brand-new user → splash.
  final String initialRoute;
  if (await SessionStore.isLoggedIn()) {
    initialRoute = HomeRoutes.dashboardOverview;
  } else if (await OnboardingFlowStore.hasCreatedAccount()) {
    initialRoute = AuthRoutes.login;
  } else {
    initialRoute = AppRoutes.splash1;
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute = AppRoutes.splash1});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
      title: 'EmSafe',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      // App-wide DANGER modal: pops "cut the power?" when one of the client's
      // own sensors reports a DANGER reading over the WebSocket.
      builder: (context, child) =>
          DangerAlertGate(child: child ?? const SizedBox.shrink()),
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
