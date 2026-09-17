import '../../../core/api_client.dart';
import '../domain/device.dart';
import '../domain/plug_state.dart';
/// Los sensores del cliente y el control de su relé.
class DeviceService {
  static Future<List<ClientDevice>> all() async =>
      ((await ApiClient.get('/client/devices')) as List)
          .map((e) => ClientDevice.fromJson(e as Map<String, dynamic>))
          .toList();

  /// Ordena al relé dar o cortar corriente. El edge recoge la orden en su
  /// siguiente ciclo y acciona el equipo (móvil → backend → edge → dispositivo).
  static Future<ClientDevice> setPlug(int deviceId, PlugState plug) async =>
      ClientDevice.fromJson(await ApiClient.patch(
        '/client/devices/$deviceId/plug',
        {'plug': plug.apiValue},
      ) as Map<String, dynamic>);
}
