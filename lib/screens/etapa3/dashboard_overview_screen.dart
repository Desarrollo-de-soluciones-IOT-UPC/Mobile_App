import 'package:flutter/material.dart';

import 'etapa3_components.dart';

class DashboardOverviewScreen extends StatelessWidget {
  const DashboardOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Etapa3Shell(
      title: 'Dashboard',
      subtitle: 'Radiation exposure monitoring live',
      selectedIndex: 0,
      trailing: const StatusPill(label: 'SAFE', color: Etapa3Palette.cyan),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ExposureHero(),
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
                childAspectRatio: compact ? 2.35 : 1.34,
                children: const [
                  MetricTile(
                    icon: Icons.living_outlined,
                    label: 'Living room',
                    value: '12.4',
                    caption: 'uW/m2 average',
                    accent: Etapa3Palette.blue,
                  ),
                  MetricTile(
                    icon: Icons.bedroom_parent_outlined,
                    label: 'Bedroom',
                    value: '8.7',
                    caption: 'uW/m2 average',
                    accent: Etapa3Palette.green,
                  ),
                  MetricTile(
                    icon: Icons.router_outlined,
                    label: 'Wi-Fi router',
                    value: '32.1',
                    caption: 'highest source',
                    accent: Etapa3Palette.amber,
                  ),
                  MetricTile(
                    icon: Icons.sensors_outlined,
                    label: 'Online sensors',
                    value: '04',
                    caption: 'all reporting',
                    accent: Etapa3Palette.cyan,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionLabel('ACTIVE ZONES'),
          const SizedBox(height: 10),
          const _ZoneRow(
            room: 'Living Room',
            value: '12.4 uW/m2',
            status: 'Normal',
            color: Etapa3Palette.green,
          ),
          const SizedBox(height: 10),
          const _ZoneRow(
            room: 'Bedroom',
            value: '8.7 uW/m2',
            status: 'Quiet',
            color: Etapa3Palette.blue,
          ),
          const SizedBox(height: 10),
          const _ZoneRow(
            room: 'Office',
            value: '24.9 uW/m2',
            status: 'Watch',
            color: Etapa3Palette.amber,
          ),
          const SizedBox(height: 18),
          GlassPanel(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Etapa3Palette.cyan.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_graph,
                    color: Etapa3Palette.cyan,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily exposure remains stable',
                        style: TextStyle(
                          color: Etapa3Palette.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'No critical spikes detected during the last 24 hours.',
                        style: TextStyle(
                          color: Etapa3Palette.muted,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExposureHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          SizedBox(
            height: 238,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 238,
                  height: 238,
                  decoration: BoxDecoration(
                    color: Etapa3Palette.cyan.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Etapa3Palette.cyan.withValues(alpha: 0.24),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Etapa3Palette.cyan.withValues(alpha: 0.18),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 172,
                  height: 172,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Etapa3Palette.cyan.withValues(alpha: 0.22),
                      width: 14,
                    ),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '42.5',
                      style: TextStyle(
                        color: Etapa3Palette.cyan,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'uW/m2',
                      style: TextStyle(
                        color: Etapa3Palette.muted,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Current exposure',
            style: TextStyle(
              color: Etapa3Palette.text,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your home is inside the recommended radiation threshold.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              value: 0.42,
              minHeight: 7,
              backgroundColor: Color(0xFF32343E),
              valueColor: AlwaysStoppedAnimation<Color>(Etapa3Palette.green),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneRow extends StatelessWidget {
  const _ZoneRow({
    required this.room,
    required this.value,
    required this.status,
    required this.color,
  });

  final String room;
  final String value;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(label: status, color: color),
        ],
      ),
    );
  }
}
