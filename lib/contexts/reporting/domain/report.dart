import '../../../core/json.dart';
/// Un cubo de agregación del informe (un día o un mes), del más antiguo al más nuevo.
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

  factory ClientReportBucket.fromJson(Map<String, dynamic> j) => ClientReportBucket(
        label: toStr(j['label']),
        average: toDoubleOrNull(j['average']) ?? 0,
        peak: toDoubleOrNull(j['peak']) ?? 0,
        readings: toIntOrZero(j['readings']),
        alerts: toIntOrZero(j['alerts']),
      );
}

/// Informe agregado de exposición: `period` = "month" | "year".
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

  bool get isYearly => period == 'year';

  factory ClientReport.fromJson(Map<String, dynamic> j) => ClientReport(
        period: (j['period'] ?? 'month').toString(),
        average: toDoubleOrNull(j['average']) ?? 0,
        peak: toDoubleOrNull(j['peak']) ?? 0,
        totalReadings: toIntOrZero(j['totalReadings']),
        totalAlerts: toIntOrZero(j['totalAlerts']),
        buckets: ((j['buckets'] as List?) ?? [])
            .map((e) => ClientReportBucket.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
