import 'package:flutter/widgets.dart';

import '../presentation/onboarding/screen_1_splash_em_safe_updated.dart';
import '../presentation/onboarding/screen_1_splash_official_brand.dart';
import '../presentation/onboarding/screen_2_onboarding_smart_alerts.dart';
import '../presentation/onboarding/screen_3_onboarding_astra_ai_assistant.dart';
import '../presentation/onboarding/screen_4_onboarding_smart_home_protection.dart';
import '../presentation/onboarding/screen_6_pairing_sensors.dart';
import '../presentation/onboarding/screen_8_onboarding_final_step.dart';
import 'auth_routes.dart';
import 'home_routes.dart';

class AppRoutes {
  static const String splash1 = '/onboarding/screen1/splash_official_brand';
  static const String splashUpdated = '/onboarding/screen1/splash_em_safe_updated';
  static const String onboardingSmartAlerts =
      '/onboarding/screen2/onboarding_smart_alerts';
  static const String onboardingAstraAssistant =
      '/onboarding/screen3/onboarding_astra_ai_assistant';
  static const String onboardingSmartHomeProtection =
      '/onboarding/screen4/onboarding_smart_home_protection';
  static const String pairingSensors = '/onboarding/screen6/pairing_sensors';
  static const String pairYourSensor = '/onboarding/screen7/pair_your_sensor';
  static const String onboardingFinalStep =
      '/onboarding/screen8/onboarding_final_step';

  static Map<String, WidgetBuilder> get routes => {
    splash1: (context) => const SplashOfficialBrandScreen(),
    splashUpdated: (context) => const SplashEmSafeUpdatedScreen(),
    onboardingSmartAlerts: (context) => const OnboardingSmartAlertsScreen(),
    onboardingAstraAssistant: (context) =>
        const OnboardingAstraAIAssistantScreen(),
    onboardingSmartHomeProtection: (context) =>
        const OnboardingSmartHomeProtectionScreen(),
    pairingSensors: (context) => const PairingSensorsScreen(),
    // Interceptado en main.dart con PageRouteBuilder(opaque:false) para efecto cristal.
    // pairYourSensor: (context) => const PairYourSensorScreen(),
    onboardingFinalStep: (context) => const OnboardingFinalStepScreen(),
    ...AuthRoutes.routes,
    ...HomeRoutes.routes,
  };
}
