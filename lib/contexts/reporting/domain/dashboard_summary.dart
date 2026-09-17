import '../../../core/json.dart';
import '../../device/domain/device.dart';
import '../../monitoring/domain/radiation_level.dart';
import '../../monitoring/domain/reading.dart';
/// Resumen del panel de la app: proyección sobre varios contextos.
///
/// Que agregue sensores (Device) y lecturas (Monitoring) es normal en un read
/// model — es exactamente lo que hace `reporting` en el backend.
class ClientDashboard {
  ClientDashboard({
    required this.deviceCount,
    required this.activeDeviceCount,
    required this.currentAverage,
    required this.maxValue,
    required this.level,
    required this.safetyThreshold,
    required this.alertCount,
    required this.devices,
    required this.latestReadings,
  });

  final int deviceCount;
  final int activeDeviceCount;
  final double currentAverage;
  final double maxValue;
  final String level;
  final double safetyThreshold;
  final int alertCount;
  final List<ClientDevice> devices;
  final List<ClientReading> latestReadings;

  /// Nivel global del cliente, según la regla compartida.
  RadiationLevel get overallLevel => levelOf(level, maxValue);

  factory ClientDashboard.fromJson(Map<String, dynamic> j) => ClientDashboard(
        deviceCount: toIntOrZero(j['deviceCount']),
        activeDeviceCount: toIntOrZero(j['activeDeviceCount']),
        currentAverage: toDoubleOrNull(j['currentAverage']) ?? 0,
        maxValue: toDoubleOrNull(j['maxValue']) ?? 0,
        level: (j['level'] ?? 'safe').toString(),
        safetyThreshold: toDoubleOrNull(j['safetyThreshold']) ?? dangerUT,
        alertCount: toIntOrZero(j['alertCount']),
        devices: ((j['devices'] as List?) ?? [])
            .map((e) => ClientDevice.fromJson(e as Map<String, dynamic>))
            .toList(),
        latestReadings: ((j['latestReadings'] as List?) ?? [])
            .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
