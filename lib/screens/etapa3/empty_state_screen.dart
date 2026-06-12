import 'package:flutter/material.dart';

import 'etapa3_components.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Etapa3Shell(
      title: 'EmSafe',
      subtitle: 'No active monitoring profile',
      selectedIndex: 0,
      trailing: const StatusPill(label: 'IDLE', color: Etapa3Palette.quiet),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 650),
        child: Column(
          children: [
            const SizedBox(height: 46),
            const _EmptyIllustration(),
            const SizedBox(height: 34),
            const Text(
              'No sensors connected',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Etapa3Palette.text,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Connect your first EmSafe sensor to start monitoring electromagnetic exposure in real time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Etapa3Palette.muted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_link),
                label: const Text('Connect Sensor'),
                style: FilledButton.styleFrom(
                  backgroundColor: Etapa3Palette.cyan,
                  foregroundColor: const Color(0xFF002B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.help_outline),
                label: const Text('View setup guide'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Etapa3Palette.blue,
                  side: const BorderSide(color: Etapa3Palette.stroke),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 34),
            const _Checklist(),
          ],
        ),
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Etapa3Palette.cyan.withValues(alpha: 0.04),
              border: Border.all(
                color: Etapa3Palette.cyan.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            top: 22,
            right: 28,
            child: _FloatBadge(
              icon: Icons.wifi_off_outlined,
              color: Etapa3Palette.amber,
            ),
          ),
          Positioned(
            left: 26,
            bottom: 34,
            child: _FloatBadge(
              icon: Icons.sensors_off_outlined,
              color: Etapa3Palette.quiet,
            ),
          ),
          GlassPanel(
            borderRadius: 18,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: Etapa3Palette.cyan.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Etapa3Palette.cyan.withValues(alpha: 0.28),
                    ),
                  ),
                  child: const Icon(
                    Icons.sensors_outlined,
                    color: Etapa3Palette.cyan,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 18),
                const StatusPill(
                  label: 'WAITING FOR DEVICE',
                  color: Etapa3Palette.cyan,
                  icon: Icons.radio_button_checked,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatBadge extends StatelessWidget {
  const _FloatBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Icon(icon, color: color, size: 26),
    );
  }
}

class _Checklist extends StatelessWidget {
  const _Checklist();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionLabel('SETUP CHECKLIST'),
          SizedBox(height: 14),
          _ChecklistItem(
            icon: Icons.power_settings_new,
            label: 'Power on your EmSafe sensor',
          ),
          SizedBox(height: 12),
          _ChecklistItem(
            icon: Icons.bluetooth_searching,
            label: 'Keep the device near your phone',
          ),
          SizedBox(height: 12),
          _ChecklistItem(
            icon: Icons.home_outlined,
            label: 'Assign the sensor to a room',
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Etapa3Palette.blue, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
