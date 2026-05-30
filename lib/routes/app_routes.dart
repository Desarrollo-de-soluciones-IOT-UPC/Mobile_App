import 'package:flutter/widgets.dart';

import '../screens/etapa1/screen_1_splash_official_brand.dart';

class AppRoutes {
  static const String splash1 = '/etapa1/screen1/splash_official_brand';

  static Map<String, WidgetBuilder> get routes => {
        splash1: (context) => const SplashOfficialBrandScreen(),
      };
}

