import 'package:flutter/material.dart';

import 'etapa3_components.dart';

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  State<SystemSettingsScreen> createState() => _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends State<SystemSettingsScreen> {
  bool pushAlerts = true;
  bool autoCalibrate = true;
  bool cloudSync = false;
  double threshold = 72;

  @override
  Widget build(BuildContext context) {
    return Etapa3Shell(
      title: 'Settings',
      subtitle: 'System preferences and sensor controls',
      selectedIndex: 3,
      trailing: const StatusPill(
        label: 'SYNC OK',
        color: Etapa3Palette.green,
        icon: Icons.cloud_done_outlined,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProfileCard(),
          const SizedBox(height: 20),
          const SectionLabel('SAFETY THRESHOLD'),
          const SizedBox(height: 10),
          GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Alert limit',
                        style: TextStyle(
                          color: Etapa3Palette.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    StatusPill(
                      label: '${threshold.round()} uW/m2',
                      color: Etapa3Palette.cyan,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'EmSafe will notify you when exposure exceeds this value.',
                  style: TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Etapa3Palette.cyan,
                    inactiveTrackColor: const Color(0xFF32343E),
                    thumbColor: Etapa3Palette.cyan,
                    overlayColor: Etapa3Palette.cyan.withValues(alpha: 0.12),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: threshold,
                    min: 20,
                    max: 100,
                    divisions: 16,
                    onChanged: (value) {
                      setState(() {
                        threshold = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionLabel('PREFERENCES'),
          const SizedBox(height: 10),
          _SettingsSwitch(
            icon: Icons.notifications_active_outlined,
            title: 'Push alerts',
            subtitle: 'Notify when exposure changes abruptly',
            value: pushAlerts,
            onChanged: (value) => setState(() => pushAlerts = value),
          ),
          const SizedBox(height: 10),
          _SettingsSwitch(
            icon: Icons.auto_fix_high_outlined,
            title: 'Auto calibration',
            subtitle: 'Refresh sensor baseline overnight',
            value: autoCalibrate,
            onChanged: (value) => setState(() => autoCalibrate = value),
          ),
          const SizedBox(height: 10),
          _SettingsSwitch(
            icon: Icons.cloud_sync_outlined,
            title: 'Cloud sync',
            subtitle: 'Back up readings and room profiles',
            value: cloudSync,
            onChanged: (value) => setState(() => cloudSync = value),
          ),
          const SizedBox(height: 20),
          const SectionLabel('SENSORS'),
          const SizedBox(height: 10),
          const _DeviceTile(
            name: 'Living Room Sensor',
            status: 'Online',
            battery: '86%',
            color: Etapa3Palette.green,
          ),
          const SizedBox(height: 10),
          const _DeviceTile(
            name: 'Bedroom Sensor',
            status: 'Online',
            battery: '74%',
            color: Etapa3Palette.green,
          ),
          const SizedBox(height: 10),
          const _DeviceTile(
            name: 'Garage Sensor',
            status: 'Low battery',
            battery: '18%',
            color: Etapa3Palette.amber,
          ),
          const SizedBox(height: 20),
          const SectionLabel('MAINTENANCE'),
          const SizedBox(height: 10),
          GlassPanel(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: const [
                _ActionRow(
                  icon: Icons.system_update_alt,
                  title: 'Firmware updates',
                  subtitle: 'Version 2.1.4 installed',
                ),
                Divider(color: Etapa3Palette.stroke, height: 1),
                _ActionRow(
                  icon: Icons.history_toggle_off,
                  title: 'Export data history',
                  subtitle: 'Download readings as CSV',
                ),
                Divider(color: Etapa3Palette.stroke, height: 1),
                _ActionRow(
                  icon: Icons.logout,
                  title: 'Sign out',
                  subtitle: 'End this secure session',
                  destructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Etapa3Palette.blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Etapa3Palette.blue.withValues(alpha: 0.22),
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Etapa3Palette.blue,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home Protection',
                  style: TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '4 rooms monitored - 3 active sensors',
                  style: TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Edit profile',
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            color: Etapa3Palette.cyan,
          ),
        ],
      ),
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  const _SettingsSwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Etapa3Palette.cyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Etapa3Palette.cyan, size: 22),
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
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: Etapa3Palette.cyan,
            activeTrackColor: Etapa3Palette.cyan.withValues(alpha: 0.28),
            inactiveThumbColor: Etapa3Palette.quiet,
            inactiveTrackColor: Etapa3Palette.stroke,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({
    required this.name,
    required this.status,
    required this.battery,
    required this.color,
  });

  final String name;
  final String status;
  final String battery;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(Icons.sensors, color: color, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(label: battery, color: color, icon: Icons.battery_5_bar),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? Etapa3Palette.red : Etapa3Palette.blue;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: destructive
                          ? Etapa3Palette.red
                          : Etapa3Palette.text,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Etapa3Palette.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Etapa3Palette.quiet,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
