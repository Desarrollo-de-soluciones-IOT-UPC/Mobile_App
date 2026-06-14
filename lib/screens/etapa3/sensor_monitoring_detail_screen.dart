import 'package:flutter/material.dart';

import '../../models/client_models.dart';
import '../../services/api_client.dart';
import '../../services/client_api.dart';
import 'etapa3_components.dart';

/// Loaded payload for the sensor screen: the client's first device + its readings.
class _SensorData {
  _SensorData(this.device, this.readings);
  final ClientDevice? device;
  final List<ClientReading> readings;
}

class SensorMonitoringDetailScreen extends StatefulWidget {
  const SensorMonitoringDetailScreen({super.key});

  @override
  State<SensorMonitoringDetailScreen> createState() =>
      _SensorMonitoringDetailScreenState();
}

class _SensorMonitoringDetailScreenState
    extends State<SensorMonitoringDetailScreen> {
  late Future<_SensorData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_SensorData> _load() async {
    final devices = await ClientApi.devices();
    if (devices.isEmpty) return _SensorData(null, const []);
    final readings = await ClientApi.deviceReadings(devices.first.id);
    return _SensorData(devices.first, readings);
  }

  void _reload() {
    setState(() => _future = _load());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_SensorData>(
      future: _future,
      builder: (context, snapshot) {
        final device = snapshot.data?.device;
        return Etapa3Shell(
          title: 'Sensor Detail',
          subtitle: device?.name ?? 'Live sensor monitoring',
          selectedIndex: 1,
          trailing: IconButton(
            tooltip: 'Refresh',
            onPressed: _reload,
            style: IconButton.styleFrom(
              backgroundColor: Etapa3Palette.panel,
              foregroundColor: Etapa3Palette.blue,
              side: const BorderSide(color: Etapa3Palette.stroke),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(Icons.refresh),
          ),
          child: _buildBody(snapshot),
        );
      },
    );
  }

  Widget _buildBody(AsyncSnapshot<_SensorData> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Etapa3Loading();
    }
    if (snapshot.hasError) {
      final msg = snapshot.error is ApiException
          ? (snapshot.error as ApiException).message
          : 'Could not load sensor data.';
      return Etapa3Error(message: msg, onRetry: _reload);
    }

    final device = snapshot.data!.device;
    final readings = snapshot.data!.readings;

    if (device == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: GlassPanel(
          child: Text(
            'You have no sensors assigned yet. Once your administrator assigns a '
            'device to your account it will appear here.',
            style: TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SensorHero(device: device),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 360;
            return GridView.count(
              crossAxisCount: compact ? 1 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: compact ? 2.35 : 1.08,
              children: [
                MetricTile(
                  icon: Icons.show_chart,
                  label: 'Latest',
                  value: etapa3Num(device.latestValue),
                  caption: '$etapa3Unit reading',
                  accent: etapa3LevelColor(device.latestLevel),
                ),
                MetricTile(
                  icon: Icons.dataset_outlined,
                  label: 'Readings',
                  value: device.readingsCount.toString(),
                  caption: 'records stored',
                  accent: Etapa3Palette.cyan,
                ),
                MetricTile(
                  icon: Icons.memory_outlined,
                  label: 'Type',
                  value: device.type.isEmpty ? '--' : device.type,
                  caption: device.serialNumber ?? '',
                  accent: Etapa3Palette.blue,
                ),
                MetricTile(
                  icon: Icons.power_settings_new,
                  label: 'Status',
                  value: device.status.isEmpty ? '--' : device.status,
                  caption: device.location ?? '',
                  accent: device.status.toLowerCase() == 'active'
                      ? Etapa3Palette.green
                      : Etapa3Palette.amber,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        const SectionLabel('SIGNAL TREND'),
        const SizedBox(height: 10),
        _TrendCard(readings: readings),
        const SizedBox(height: 20),
        const SectionLabel('RECENT READINGS'),
        const SizedBox(height: 10),
        if (readings.isEmpty)
          const GlassPanel(
            child: Text(
              'No readings recorded for this sensor yet.',
              style: TextStyle(color: Etapa3Palette.muted, fontSize: 13),
            ),
          )
        else
          for (final reading in readings.take(8)) ...[
            _ReadingRow(reading: reading),
            const SizedBox(height: 10),
          ],
      ],
    );
  }
}

class _SensorHero extends StatelessWidget {
  const _SensorHero({required this.device});

  final ClientDevice device;

  @override
  Widget build(BuildContext context) {
    final color = etapa3LevelColor(device.latestLevel);
    final online = device.status.toLowerCase() == 'active';
    final double progress = (device.latestValue ?? 0) / 0.5;

    return GlassPanel(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            children: [
              StatusPill(
                label: online ? 'ONLINE' : device.status.toUpperCase(),
                color: online ? Etapa3Palette.green : Etapa3Palette.amber,
              ),
              const Spacer(),
              Text(
                device.latestReadingDate != null
                    ? 'Updated ${device.latestReadingDate}'
                    : 'No data yet',
                style: TextStyle(
                  color: Etapa3Palette.quiet.withValues(alpha: 0.9),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: 154,
            height: 154,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.06),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.16), blurRadius: 28),
              ],
            ),
            child: Icon(Icons.sensors, color: color, size: 76),
          ),
          const SizedBox(height: 26),
          Text(
            etapa3Num(device.latestValue),
            style: const TextStyle(
              color: Etapa3Palette.text,
              fontSize: 56,
              fontWeight: FontWeight.w900,
              height: 0.95,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '$etapa3Unit current exposure',
            style: TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: const Color(0xFF32343E),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.readings});

  final List<ClientReading> readings;

  @override
  Widget build(BuildContext context) {
    // readings come newest-first; take a window and show oldest→newest.
    final window = readings.take(12).toList().reversed.toList();
    final values = window
        .map((r) => r.value ?? 0)
        .where((v) => v >= 0)
        .toList();
    final maxVal = values.isEmpty
        ? 1.0
        : values.reduce((a, b) => a > b ? a : b);
    final safeMax = maxVal <= 0 ? 1.0 : maxVal;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recent readings',
                  style: TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              StatusPill(
                label: '${window.length} pts',
                color: Etapa3Palette.cyan,
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 110,
            child: window.isEmpty
                ? const Center(
                    child: Text(
                      'No readings to chart yet.',
                      style:
                          TextStyle(color: Etapa3Palette.quiet, fontSize: 12),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final reading in window) ...[
                        Expanded(
                          child: FractionallySizedBox(
                            heightFactor:
                                ((reading.value ?? 0) / safeMax).clamp(0.04, 1.0),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: etapa3LevelColor(reading.level)
                                    .withValues(alpha: 0.72),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                    ],
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            'Peak in this window: ${etapa3Num(safeMax)} $etapa3Unit.',
            style: const TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadingRow extends StatelessWidget {
  const _ReadingRow({required this.reading});

  final ClientReading reading;

  @override
  Widget build(BuildContext context) {
    final color = etapa3LevelColor(reading.level);
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.22)),
            ),
            child: Icon(Icons.bolt, color: color, size: 23),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${etapa3Num(reading.value)} $etapa3Unit',
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reading.readingDate ?? '',
                  style: const TextStyle(
                    color: Etapa3Palette.quiet,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(label: etapa3LevelLabel(reading.level), color: color),
        ],
      ),
    );
  }
}
