import 'package:flutter/material.dart';

import 'etapa3_components.dart';

class SensorMonitoringDetailScreen extends StatelessWidget {
  const SensorMonitoringDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Etapa3Shell(
      title: 'Sensor Detail',
      subtitle: 'Living room sensor EM-204',
      selectedIndex: 1,
      trailing: IconButton(
        tooltip: 'Calibrate sensor',
        onPressed: () {},
        style: IconButton.styleFrom(
          backgroundColor: Etapa3Palette.panel,
          foregroundColor: Etapa3Palette.blue,
          side: const BorderSide(color: Etapa3Palette.stroke),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.tune),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SensorHero(),
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
                childAspectRatio: compact ? 2.6 : 1.28,
                children: const [
                  MetricTile(
                    icon: Icons.battery_charging_full_outlined,
                    label: 'Battery',
                    value: '86%',
                    caption: 'charging healthy',
                    accent: Etapa3Palette.green,
                  ),
                  MetricTile(
                    icon: Icons.wifi_tethering,
                    label: 'Signal',
                    value: '-42',
                    caption: 'dBm strong link',
                    accent: Etapa3Palette.cyan,
                  ),
                  MetricTile(
                    icon: Icons.device_thermostat_outlined,
                    label: 'Temperature',
                    value: '23 C',
                    caption: 'sensor enclosure',
                    accent: Etapa3Palette.blue,
                  ),
                  MetricTile(
                    icon: Icons.update,
                    label: 'Last sync',
                    value: '12s',
                    caption: 'ago',
                    accent: Etapa3Palette.amber,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionLabel('SIGNAL TREND'),
          const SizedBox(height: 10),
          const _TrendCard(),
          const SizedBox(height: 20),
          const SectionLabel('DETECTED SOURCES'),
          const SizedBox(height: 10),
          const _SourceRow(
            icon: Icons.router_outlined,
            title: 'Wi-Fi router',
            subtitle: '2.4 GHz band, 1.6 m away',
            value: '18.2',
            color: Etapa3Palette.amber,
          ),
          const SizedBox(height: 10),
          const _SourceRow(
            icon: Icons.phone_android_outlined,
            title: 'Mobile device',
            subtitle: 'intermittent burst',
            value: '7.5',
            color: Etapa3Palette.cyan,
          ),
          const SizedBox(height: 10),
          const _SourceRow(
            icon: Icons.tv_outlined,
            title: 'Smart TV',
            subtitle: 'standby emission',
            value: '4.1',
            color: Etapa3Palette.blue,
          ),
        ],
      ),
    );
  }
}

class _SensorHero extends StatelessWidget {
  const _SensorHero();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            children: [
              const StatusPill(label: 'ONLINE', color: Etapa3Palette.green),
              const Spacer(),
              Text(
                'Updated just now',
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
              color: Etapa3Palette.cyan.withValues(alpha: 0.06),
              border: Border.all(
                color: Etapa3Palette.cyan.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Etapa3Palette.cyan.withValues(alpha: 0.16),
                  blurRadius: 28,
                ),
              ],
            ),
            child: const Icon(
              Icons.sensors,
              color: Etapa3Palette.cyan,
              size: 76,
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            '12.4',
            style: TextStyle(
              color: Etapa3Palette.text,
              fontSize: 56,
              fontWeight: FontWeight.w900,
              height: 0.95,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'uW/m2 current exposure',
            style: TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              value: 0.24,
              minHeight: 8,
              backgroundColor: Color(0xFF32343E),
              valueColor: AlwaysStoppedAnimation<Color>(Etapa3Palette.green),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard();

  @override
  Widget build(BuildContext context) {
    final bars = [0.35, 0.48, 0.42, 0.56, 0.38, 0.62, 0.44, 0.31, 0.4, 0.28];

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Last 30 minutes',
                  style: TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              StatusPill(label: 'STABLE', color: Etapa3Palette.green),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final value in bars) ...[
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: value,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Etapa3Palette.cyan.withValues(alpha: 0.72),
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
          const Text(
            'Average exposure is 18% lower than yesterday in this zone.',
            style: TextStyle(
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

class _SourceRow extends StatelessWidget {
  const _SourceRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
            child: Icon(icon, color: color, size: 23),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Etapa3Palette.quiet,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
