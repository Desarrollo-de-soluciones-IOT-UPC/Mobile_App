import 'package:flutter/widgets.dart';

import '../screens/etapa3/dashboard_overview_screen.dart';

class Etapa3Routes {
  static const String dashboardOverview = '/etapa3/dashboard-overview';

  static Map<String, WidgetBuilder> get routes => {
    dashboardOverview: (context) => const DashboardOverviewScreen(),
  };
}
