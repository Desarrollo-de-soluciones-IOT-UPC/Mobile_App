import 'package:flutter/widgets.dart';

import '../screens/etapa3/dashboard_overview_screen.dart';
import '../screens/etapa3/sensor_monitoring_detail_screen.dart';

class Etapa3Routes {
  static const String dashboardOverview = '/etapa3/dashboard-overview';
  static const String sensorMonitoringDetail =
      '/etapa3/sensor-monitoring-detail';

  static Map<String, WidgetBuilder> get routes => {
    dashboardOverview: (context) => const DashboardOverviewScreen(),
    sensorMonitoringDetail: (context) => const SensorMonitoringDetailScreen(),
  };
}
