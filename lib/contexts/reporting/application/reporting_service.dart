import '../../../core/api_client.dart';
import '../domain/dashboard_summary.dart';
import '../domain/report.dart';
/// Panel e informes: las dos proyecciones de sólo lectura de la app.
class ReportingService {
  static Future<ClientDashboard> dashboard() async => ClientDashboard.fromJson(
      await ApiClient.get('/client/dashboard') as Map<String, dynamic>);

  /// Informe agregado de exposición: `period` = "month" | "year".
  static Future<ClientReport> report(String period) async =>
      ClientReport.fromJson(
          await ApiClient.get('/client/reports?period=$period')
              as Map<String, dynamic>);
}
