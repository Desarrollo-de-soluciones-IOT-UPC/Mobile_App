import '../../../core/json.dart';
import '../../monitoring/domain/radiation_level.dart';
import 'plug_state.dart';

/// Un sensor del cliente, con la instantánea de su última lectura.
class ClientDevice {
  ClientDevice({
    required this.id,
    required this.name,
    required this.type,
    this.location,
    required this.status,
    this.serialNumber,
    this.installDate,
    this.latestValue,
    this.latestLevel,
    this.latestReadingDate,
    required this.readingsCount,
    this.plug,
    this.desiredPlug,
  });

  final int id;
  final String name;
  final String type;
  final String? location;
  final String status;
  final String? serialNumber;
  final String? installDate;
  final double? latestValue;
  final String? latestLevel;
  final String? latestReadingDate;
  final int readingsCount;

  /// Estado del relé reportado por el equipo en su última lectura.
  final String? plug;

  /// Estado del relé ordenado por el usuario desde la app.
  final String? desiredPlug;

  /// Nivel actual del sensor, según la regla compartida.
  RadiationLevel get currentLevel => levelOf(latestLevel, latestValue);

  PlugState? get reportedPlug => PlugState.fromApi(plug);

  PlugState? get orderedPlug => PlugState.fromApi(desiredPlug);

  bool get hasReadings => latestValue != null;

  factory ClientDevice.fromJson(Map<String, dynamic> j) => ClientDevice(
        id: toIntOrZero(j['id']),
        name: toStr(j['name']),
        type: toStr(j['type']),
        location: j['location']?.toString(),
        status: toStr(j['status']),
        serialNumber: j['serialNumber']?.toString(),
        installDate: j['installDate']?.toString(),
        latestValue: toDoubleOrNull(j['latestValue']),
        latestLevel: j['latestLevel']?.toString(),
        latestReadingDate: j['latestReadingDate']?.toString(),
        readingsCount: toIntOrZero(j['readingsCount']),
        plug: j['plug']?.toString(),
        desiredPlug: j['desiredPlug']?.toString(),
      );
}
