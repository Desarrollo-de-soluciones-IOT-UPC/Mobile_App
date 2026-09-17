import '../../../core/api_client.dart';
import '../domain/alert.dart';
/// Alertas del cliente, derivadas de sus propias lecturas.
class AlertService {
  static Future<List<ClientAlert>> all() async =>
      ((await ApiClient.get('/client/alerts')) as List)
          .map((e) => ClientAlert.fromJson(e as Map<String, dynamic>))
          .toList();
}
