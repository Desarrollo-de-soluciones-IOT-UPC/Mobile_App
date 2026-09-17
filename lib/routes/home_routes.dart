import 'package:flutter/widgets.dart';

import '../presentation/home/alert_history_screen.dart';
import '../presentation/home/dashboard_overview_screen.dart';
import '../presentation/home/empty_state_screen.dart';
import '../presentation/home/monitor_screen.dart';
import '../presentation/home/sensor_monitoring_detail_screen.dart';
import '../presentation/home/system_settings_screen.dart';
class HomeRoutes {
  static const String alertHistory = '/home/alert-history';
  static const String dashboardOverview = '/home/dashboard-overview';
  static const String emptyState = '/home/empty-state';
  static const String monitor = '/home/monitor';
  static const String sensorMonitoringDetail =
      '/home/sensor-monitoring-detail';
  static const String systemSettings = '/home/system-settings';

  static Map<String, WidgetBuilder> get routes => {
    alertHistory: (context) => const AlertHistoryScreen(),
    dashboardOverview: (context) => const DashboardOverviewScreen(),
    emptyState: (context) => const EmptyStateScreen(),
    monitor: (context) => const MonitorScreen(),
    sensorMonitoringDetail: (context) => const SensorMonitoringDetailScreen(),
    systemSettings: (context) => const SystemSettingsScreen(),
  };
}
