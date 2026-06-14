import 'package:flutter/material.dart';

import '../../models/client_models.dart';
import '../../routes/etapa2_routes.dart';
import '../../services/api_client.dart';
import '../../services/client_api.dart';
import '../../services/session_store.dart';
import 'etapa3_components.dart';

class _SettingsData {
  _SettingsData(this.profile, this.devices);
  final ClientProfile profile;
  final List<ClientDevice> devices;
}

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  State<SystemSettingsScreen> createState() => _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends State<SystemSettingsScreen> {
  bool pushAlerts = true;
  bool autoCalibrate = true;
  bool cloudSync = false;

  late Future<_SettingsData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_SettingsData> _load() async {
    final profile = await ClientApi.profile();
    final devices = await ClientApi.devices();
    return _SettingsData(profile, devices);
  }

  void _reload() {
    setState(() => _future = _load());
  }

  Future<void> _signOut() async {
    await SessionStore.clear();
    if (!mounted) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Etapa2Routes.login, (route) => false);
  }

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
      child: FutureBuilder<_SettingsData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Etapa3Loading();
          }
          if (snapshot.hasError) {
            final msg = snapshot.error is ApiException
                ? (snapshot.error as ApiException).message
                : 'Could not load settings.';
            return Etapa3Error(message: msg, onRetry: _reload);
          }
          return _buildBody(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildBody(_SettingsData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileCard(profile: data.profile, deviceCount: data.devices.length),
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
        if (data.devices.isEmpty)
          const GlassPanel(
            child: Text(
              'No sensors assigned to your account yet.',
              style: TextStyle(color: Etapa3Palette.muted, fontSize: 13),
            ),
          )
        else
          for (final device in data.devices) ...[
            _DeviceTile(device: device),
            const SizedBox(height: 10),
          ],
        const SizedBox(height: 20),
        const SectionLabel('MAINTENANCE'),
        const SizedBox(height: 10),
        GlassPanel(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const _ActionRow(
                icon: Icons.system_update_alt,
                title: 'Firmware updates',
                subtitle: 'Version 2.1.4 installed',
              ),
              const Divider(color: Etapa3Palette.stroke, height: 1),
              const _ActionRow(
                icon: Icons.history_toggle_off,
                title: 'Export data history',
                subtitle: 'Download readings as CSV',
              ),
              const Divider(color: Etapa3Palette.stroke, height: 1),
              _ActionRow(
                icon: Icons.logout,
                title: 'Sign out',
                subtitle: 'End this secure session',
                destructive: true,
                onTap: _signOut,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile, required this.deviceCount});

  final ClientProfile profile;
  final int deviceCount;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Etapa3Palette.blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Etapa3Palette.blue.withValues(alpha: 0.22),
              ),
            ),
            child: Text(
              (profile.initials?.isNotEmpty == true
                  ? profile.initials!
                  : (profile.name.isNotEmpty ? profile.name[0] : '?')),
              style: const TextStyle(
                color: Etapa3Palette.blue,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name.isEmpty ? 'My account' : profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$deviceCount sensor${deviceCount == 1 ? '' : 's'} monitored'
                  '${profile.address != null ? ' · ${profile.address}' : ''}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Etapa3Palette.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
  const _DeviceTile({required this.device});

  final ClientDevice device;

  @override
  Widget build(BuildContext context) {
    final active = device.status.toLowerCase() == 'active';
    final color = active ? Etapa3Palette.green : Etapa3Palette.amber;
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
                  device.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  active ? 'Online' : device.status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(
            label: device.latestValue != null
                ? '${etapa3Num(device.latestValue)} $etapa3Unit'
                : '--',
            color: etapa3LevelColor(device.latestLevel),
          ),
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
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool destructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? Etapa3Palette.red : Etapa3Palette.blue;
    return InkWell(
      onTap: onTap ?? () {},
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
