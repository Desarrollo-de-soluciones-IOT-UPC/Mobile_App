import 'package:flutter/widgets.dart';

import '../screens/etapa3/alert_history_screen.dart';
import '../screens/etapa3/dashboard_overview_screen.dart';
import '../screens/etapa3/empty_state_screen.dart';
import '../screens/etapa3/sensor_monitoring_detail_screen.dart';

class Etapa3Routes {
  static const String alertHistory = '/etapa3/alert-history';
  static const String dashboardOverview = '/etapa3/dashboard-overview';
  static const String emptyState = '/etapa3/empty-state';
  static const String sensorMonitoringDetail =
      '/etapa3/sensor-monitoring-detail';

  static Map<String, WidgetBuilder> get routes => {
    alertHistory: (context) => const AlertHistoryScreen(),
    dashboardOverview: (context) => const DashboardOverviewScreen(),
    emptyState: (context) => const EmptyStateScreen(),
    sensorMonitoringDetail: (context) => const SensorMonitoringDetailScreen(),
  };
}
