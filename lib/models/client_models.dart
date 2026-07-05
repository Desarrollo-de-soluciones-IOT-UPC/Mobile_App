/// Models mirroring the backend `/api/client/**` DTOs.

double? _toDouble(dynamic v) => v == null ? null : (v as num).toDouble();
int _toInt(dynamic v) => v == null ? 0 : (v as num).toInt();

class ClientProfile {
  ClientProfile({
    required this.id,
    required this.name,
    required this.initials,
    required this.email,
    required this.role,
    this.phone,
    this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.joinDate,
  });

  final int id;
  final String name;
  final String? initials;
  final String email;
  final String role;
  final String? phone;
  final String? location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? joinDate;

  factory ClientProfile.fromJson(Map<String, dynamic> j) => ClientProfile(
        id: _toInt(j['id']),
        name: (j['name'] ?? '').toString(),
        initials: j['initials']?.toString(),
        email: (j['email'] ?? '').toString(),
        role: (j['role'] ?? '').toString(),
        phone: j['phone']?.toString(),
        location: j['location']?.toString(),
        address: j['address']?.toString(),
        latitude: _toDouble(j['latitude']),
        longitude: _toDouble(j['longitude']),
        joinDate: j['joinDate']?.toString(),
      );
}

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

  /// Relay state reported by the device in its latest reading (ON | OFF | null).
  final String? plug;

  /// Relay state the user ordered from the app (ON | OFF | null = no order yet).
  final String? desiredPlug;

  factory ClientDevice.fromJson(Map<String, dynamic> j) => ClientDevice(
        id: _toInt(j['id']),
        name: (j['name'] ?? '').toString(),
        type: (j['type'] ?? '').toString(),
        location: j['location']?.toString(),
        status: (j['status'] ?? '').toString(),
        serialNumber: j['serialNumber']?.toString(),
        installDate: j['installDate']?.toString(),
        latestValue: _toDouble(j['latestValue']),
        latestLevel: j['latestLevel']?.toString(),
        latestReadingDate: j['latestReadingDate']?.toString(),
        readingsCount: _toInt(j['readingsCount']),
        plug: j['plug']?.toString(),
        desiredPlug: j['desiredPlug']?.toString(),
      );
}

class ClientReading {
  ClientReading({
    required this.id,
    this.value,
    this.level,
    this.readingDate,
    this.deviceId,
    this.deviceName,
  });

  final int id;
  final double? value;
  final String? level;
  final String? readingDate;
  final int? deviceId;
  final String? deviceName;

  factory ClientReading.fromJson(Map<String, dynamic> j) => ClientReading(
        id: _toInt(j['id']),
        value: _toDouble(j['value']),
        level: j['level']?.toString(),
        readingDate: j['readingDate']?.toString(),
        deviceId: j['deviceId'] == null ? null : _toInt(j['deviceId']),
        deviceName: j['deviceName']?.toString(),
      );
}

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

  factory ClientAlert.fromJson(Map<String, dynamic> j) => ClientAlert(
        id: _toInt(j['id']),
        type: (j['type'] ?? '').toString(),
        level: (j['level'] ?? '').toString(),
        title: (j['title'] ?? '').toString(),
        description: (j['description'] ?? '').toString(),
        value: _toDouble(j['value']),
        deviceId: j['deviceId'] == null ? null : _toInt(j['deviceId']),
        deviceName: j['deviceName']?.toString(),
        time: j['time']?.toString(),
      );
}

class ClientReportBucket {
  ClientReportBucket({
    required this.label,
    required this.average,
    required this.peak,
    required this.readings,
    required this.alerts,
  });

  final String label;
  final double average;
  final double peak;
  final int readings;
  final int alerts;

  factory ClientReportBucket.fromJson(Map<String, dynamic> j) =>
      ClientReportBucket(
        label: (j['label'] ?? '').toString(),
        average: _toDouble(j['average']) ?? 0,
        peak: _toDouble(j['peak']) ?? 0,
        readings: _toInt(j['readings']),
        alerts: _toInt(j['alerts']),
      );
}

class ClientReport {
  ClientReport({
    required this.period,
    required this.average,
    required this.peak,
    required this.totalReadings,
    required this.totalAlerts,
    required this.buckets,
  });

  final String period;
  final double average;
  final double peak;
  final int totalReadings;
  final int totalAlerts;
  final List<ClientReportBucket> buckets;

  factory ClientReport.fromJson(Map<String, dynamic> j) => ClientReport(
        period: (j['period'] ?? 'month').toString(),
        average: _toDouble(j['average']) ?? 0,
        peak: _toDouble(j['peak']) ?? 0,
        totalReadings: _toInt(j['totalReadings']),
        totalAlerts: _toInt(j['totalAlerts']),
        buckets: ((j['buckets'] as List?) ?? [])
            .map((e) => ClientReportBucket.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

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

  factory ClientDashboard.fromJson(Map<String, dynamic> j) => ClientDashboard(
        deviceCount: _toInt(j['deviceCount']),
        activeDeviceCount: _toInt(j['activeDeviceCount']),
        currentAverage: _toDouble(j['currentAverage']) ?? 0,
        maxValue: _toDouble(j['maxValue']) ?? 0,
        level: (j['level'] ?? 'safe').toString(),
        safetyThreshold: _toDouble(j['safetyThreshold']) ?? 200,
        alertCount: _toInt(j['alertCount']),
        devices: ((j['devices'] as List?) ?? [])
            .map((e) => ClientDevice.fromJson(e as Map<String, dynamic>))
            .toList(),
        latestReadings: ((j['latestReadings'] as List?) ?? [])
            .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
