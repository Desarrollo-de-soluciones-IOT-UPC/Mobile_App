import '../../../core/json.dart';
import '../../monitoring/domain/radiation_level.dart';
/// Alerta derivada de una lectura del cliente que superó el umbral de precaución.
///
/// El backend las calcula a partir de las lecturas del propio cliente: el agregado
/// `Alert` del contexto Alerting es global y no tiene relación con un cliente.
class ClientAlert {
  ClientAlert({
    required this.id,
    required this.type,
    required this.level,
    required this.title,
    required this.description,
    this.value,
    this.deviceId,
    this.deviceName,
    this.time,
    this.recordedAt,
  });

  final int id;
  final String type;
  final String level;
  final String title;
  final String description;
  final double? value;
  final int? deviceId;
  final String? deviceName;
  final String? time;

  /// Marca ISO exacta (para el "hace 36 min").
  final String? recordedAt;

  RadiationLevel get severity => levelOf(level, value);

  bool get isDangerous => severity.isDangerous;

  factory ClientAlert.fromJson(Map<String, dynamic> j) => ClientAlert(
        id: toIntOrZero(j['id']),
        type: toStr(j['type']),
        level: toStr(j['level']),
        title: toStr(j['title']),
        description: toStr(j['description']),
        value: toDoubleOrNull(j['value']),
        deviceId: toIntOrNull(j['deviceId']),
        deviceName: j['deviceName']?.toString(),
        time: j['time']?.toString(),
        recordedAt: j['recordedAt']?.toString(),
      );
}
