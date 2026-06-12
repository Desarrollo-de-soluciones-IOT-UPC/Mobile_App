import 'package:flutter/material.dart';

import 'etapa3_components.dart';

class AlertHistoryScreen extends StatelessWidget {
  const AlertHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Etapa3Shell(
      title: 'Alert History',
      subtitle: 'Review exposure events and status changes',
      selectedIndex: 2,
      trailing: IconButton(
        tooltip: 'Filter alerts',
        onPressed: () {},
        style: IconButton.styleFrom(
          backgroundColor: Etapa3Palette.panel,
          foregroundColor: Etapa3Palette.blue,
          side: const BorderSide(color: Etapa3Palette.stroke),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.filter_list),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _AlertSummary(),
          SizedBox(height: 18),
          _FilterRow(),
          SizedBox(height: 18),
          SectionLabel('TODAY'),
          SizedBox(height: 10),
          _AlertCard(
            severity: 'High exposure',
            location: 'Office sensor',
            time: '10:42 AM',
            value: '84.6 uW/m2',
            description: 'Exposure passed your configured safety threshold.',
            color: Etapa3Palette.red,
            icon: Icons.warning_amber_rounded,
          ),
          SizedBox(height: 10),
          _AlertCard(
            severity: 'Signal recovered',
            location: 'Bedroom sensor',
            time: '09:18 AM',
            value: 'Online',
            description: 'Sensor reconnected after a short network drop.',
            color: Etapa3Palette.green,
            icon: Icons.wifi_tethering,
          ),
          SizedBox(height: 20),
          SectionLabel('YESTERDAY'),
          SizedBox(height: 10),
          _AlertCard(
            severity: 'Medium spike',
            location: 'Living room',
            time: '08:54 PM',
            value: '51.2 uW/m2',
            description: 'Short burst detected near entertainment devices.',
            color: Etapa3Palette.amber,
            icon: Icons.bolt,
          ),
          SizedBox(height: 10),
          _AlertCard(
            severity: 'Calibration complete',
            location: 'Kitchen sensor',
            time: '02:31 PM',
            value: 'OK',
            description: 'Baseline profile was updated successfully.',
            color: Etapa3Palette.cyan,
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: 10),
          _AlertCard(
            severity: 'Low battery',
            location: 'Garage sensor',
            time: '11:06 AM',
            value: '18%',
            description: 'Battery replacement recommended this week.',
            color: Etapa3Palette.amber,
            icon: Icons.battery_alert_outlined,
          ),
        ],
      ),
    );
  }
}

class _AlertSummary extends StatelessWidget {
  const _AlertSummary();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Etapa3Palette.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Etapa3Palette.red.withValues(alpha: 0.24),
                  ),
                ),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  color: Etapa3Palette.red,
                  size: 27,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 events logged',
                      style: TextStyle(
                        color: Etapa3Palette.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'One high priority alert needs review.',
                      style: TextStyle(
                        color: Etapa3Palette.muted,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _SummaryStat(
                  label: 'High',
                  value: '01',
                  color: Etapa3Palette.red,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _SummaryStat(
                  label: 'Medium',
                  value: '02',
                  color: Etapa3Palette.amber,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _SummaryStat(
                  label: 'Resolved',
                  value: '04',
                  color: Etapa3Palette.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _FilterPill(label: 'All', selected: true),
          _FilterPill(label: 'High'),
          _FilterPill(label: 'Medium'),
          _FilterPill(label: 'Resolved'),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Etapa3Palette.cyan : Etapa3Palette.quiet;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected
              ? Etapa3Palette.cyan.withValues(alpha: 0.1)
              : Etapa3Palette.panel,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.severity,
    required this.location,
    required this.time,
    required this.value,
    required this.description,
    required this.color,
    required this.icon,
  });

  final String severity;
  final String location;
  final String time;
  final String value;
  final String description;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.24)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        severity,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Etapa3Palette.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Etapa3Palette.quiet,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  location,
                  style: const TextStyle(
                    color: Etapa3Palette.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                StatusPill(label: value, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
