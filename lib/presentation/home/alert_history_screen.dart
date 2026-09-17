import 'package:flutter/material.dart';

import '../../core/api_client.dart';
import '../../core/app_i18n.dart';

import 'home_components.dart';
import '../../contexts/alerting/application/alert_service.dart';
import '../../contexts/alerting/domain/alert.dart';
import '../../contexts/monitoring/domain/radiation_level.dart';

class AlertHistoryScreen extends StatefulWidget {
  const AlertHistoryScreen({super.key});

  @override
  State<AlertHistoryScreen> createState() => _AlertHistoryScreenState();
}

class _AlertHistoryScreenState extends State<AlertHistoryScreen> {
  late Future<List<ClientAlert>> _future;

  @override
  void initState() {
    super.initState();
    _future = AlertService.all();
  }

  void _reload() {
    setState(() => _future = AlertService.all());
  }

  @override
  Widget build(BuildContext context) {
    return HomeShell(
      title: tr('al_title'),
      subtitle: tr('al_subtitle'),
      selectedIndex: 3,
      trailing: IconButton(
        tooltip: tr('common_refresh'),
        onPressed: _reload,
        style: IconButton.styleFrom(
          backgroundColor: HomePalette.panel,
          foregroundColor: HomePalette.blue,
          side: const BorderSide(color: HomePalette.stroke),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.refresh),
      ),
      child: FutureBuilder<List<ClientAlert>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HomeLoading();
          }
          if (snapshot.hasError) {
            final msg = snapshot.error is ApiException
                ? (snapshot.error as ApiException).message
                : tr('al_errLoad');
            return HomeError(message: msg, onRetry: _reload);
          }
          return _buildList(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildList(List<ClientAlert> alerts) {
    final high = alerts.where((a) => a.level == 'danger').length;
    final medium = alerts.where((a) => a.level == 'caution').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AlertSummary(total: alerts.length, high: high, medium: medium),
        const SizedBox(height: 18),
        SectionLabel(tr('al_events')),
        const SizedBox(height: 10),
        if (alerts.isEmpty)
          GlassPanel(
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    color: HomePalette.green, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tr('al_empty'),
                    style: const TextStyle(
                      color: HomePalette.muted,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          for (final alert in alerts) ...[
            _AlertCard(alert: alert),
            const SizedBox(height: 10),
          ],
      ],
    );
  }
}

class _AlertSummary extends StatelessWidget {
  const _AlertSummary({
    required this.total,
    required this.high,
    required this.medium,
  });

  final int total;
  final int high;
  final int medium;

  @override
  Widget build(BuildContext context) {
    final hasHigh = high > 0;
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
                  color: (hasHigh ? HomePalette.red : HomePalette.green)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (hasHigh ? HomePalette.red : HomePalette.green)
                        .withValues(alpha: 0.24),
                  ),
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: hasHigh ? HomePalette.red : HomePalette.green,
                  size: 27,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$total ${tr('al_eventsLogged')}',
                      style: const TextStyle(
                        color: HomePalette.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      hasHigh
                          ? '$high ${tr('al_highNeedReview')}'
                          : tr('al_noHigh'),
                      style: const TextStyle(
                        color: HomePalette.muted,
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
            children: [
              Expanded(
                child: _SummaryStat(
                  label: tr('al_high'),
                  value: high.toString().padLeft(2, '0'),
                  color: HomePalette.red,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryStat(
                  label: tr('al_medium'),
                  value: medium.toString().padLeft(2, '0'),
                  color: HomePalette.amber,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryStat(
                  label: tr('al_total'),
                  value: total.toString().padLeft(2, '0'),
                  color: HomePalette.cyan,
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
              color: HomePalette.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final ClientAlert alert;

  @override
  Widget build(BuildContext context) {
    final color = levelColor(alert.level);
    final icon = alert.level == 'danger'
        ? Icons.warning_amber_rounded
        : Icons.bolt;
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
                        alert.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HomePalette.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      timeAgo(alert.recordedAt, fallbackDate: alert.time),
                      style: const TextStyle(
                        color: HomePalette.quiet,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  alert.deviceName ?? 'Sensor',
                  style: const TextStyle(
                    color: HomePalette.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  alert.description,
                  style: const TextStyle(
                    color: HomePalette.muted,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                StatusPill(
                  label: '${formatNum(alert.value)} $radiationUnit',
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
