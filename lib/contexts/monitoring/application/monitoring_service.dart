import '../../../core/api_client.dart';
import '../domain/reading.dart';
/// Lecturas de telemetría del cliente.
class MonitoringService {
  /// Todas las lecturas del cliente (historial, exportación CSV).
  static Future<List<ClientReading>> all() async =>
      ((await ApiClient.get('/client/readings')) as List)
          .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
          .toList();

  static Future<List<ClientReading>> ofDevice(int deviceId) async =>
      ((await ApiClient.get('/client/devices/$deviceId/readings')) as List)
          .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
          .toList();
}
