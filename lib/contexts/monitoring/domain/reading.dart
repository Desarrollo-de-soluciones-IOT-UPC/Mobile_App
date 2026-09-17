import '../../../core/json.dart';
import 'radiation_level.dart';

/// Una lectura de radiación de uno de los sensores del cliente.
class ClientReading {
  ClientReading({
    required this.id,
    this.value,
    this.level,
    this.readingDate,
    this.recordedAt,
    this.deviceId,
    this.deviceName,
  });

  final int id;
  final double? value;
  final String? level;
  final String? readingDate;

  /// Marca ISO exacta de la medición.
  final String? recordedAt;
  final int? deviceId;
  final String? deviceName;

  /// Nivel efectivo de esta lectura, según la regla compartida.
  RadiationLevel get effectiveLevel => levelOf(level, value);

  bool get isDangerous => effectiveLevel.isDangerous;

  factory ClientReading.fromJson(Map<String, dynamic> j) => ClientReading(
        id: toIntOrZero(j['id']),
        value: toDoubleOrNull(j['value']),
        level: j['level']?.toString(),
        readingDate: j['readingDate']?.toString(),
        recordedAt: j['recordedAt']?.toString(),
        deviceId: toIntOrNull(j['deviceId']),
        deviceName: j['deviceName']?.toString(),
      );
}
