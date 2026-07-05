import 'package:flutter/material.dart';

import '../../models/client_models.dart';
import '../../services/app_i18n.dart';
import '../../services/client_api.dart';
import 'etapa3_components.dart';

/// "Vitals" tab — electromagnetic health guidance.
///
/// The educational content (categories and tips) is static by design; the
/// CURRENT RISK card is real: it derives from the client's dashboard level
/// (safe → low, caution → moderate, danger → high). If the backend is not
/// reachable the card falls back to "moderate" without blocking the content.
class SensorMonitoringDetailScreen extends StatefulWidget {
  const SensorMonitoringDetailScreen({super.key});

  @override
  State<SensorMonitoringDetailScreen> createState() =>
      _SensorMonitoringDetailScreenState();
}

class _SensorMonitoringDetailScreenState
    extends State<SensorMonitoringDetailScreen> {
  String? _level; // backend level: safe | caution | danger

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    try {
      final ClientDashboard dash = await ClientApi.dashboard();
      if (mounted) setState(() => _level = dash.level);
    } catch (_) {
      // Informational screen: keep the fallback risk if the API is offline.
    }
  }

  @override
  Widget build(BuildContext context) {
    final risk = _RiskInfo.fromLevel(_level);

    return Etapa3Shell(
      title: tr('vit_title'),
      subtitle: tr('vit_subtitle'),
      selectedIndex: 2,
      trailing: StatusPill(label: risk.label, color: risk.color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(tr('vit_currentRisk')),
          const SizedBox(height: 10),
          _CurrentRiskCard(risk: risk),
          const SizedBox(height: 20),
          SectionLabel(tr('vit_levels')),
          const SizedBox(height: 10),
          _RiskLevelRow(
            color: Etapa3Palette.green,
            icon: Icons.check_circle_outline,
            label: tr('vit_lvLow'),
            title: tr('vit_riskLowTitle'),
            description: tr('vit_riskLowDesc'),
            active: risk.tier == 0,
          ),
          const SizedBox(height: 10),
          _RiskLevelRow(
            color: Etapa3Palette.amber,
            icon: Icons.shield_outlined,
            label: tr('vit_lvMid'),
            title: tr('vit_riskModTitle'),
            description: tr('vit_riskModDesc'),
            active: risk.tier == 1,
          ),
          const SizedBox(height: 10),
          _RiskLevelRow(
            color: Etapa3Palette.red,
            icon: Icons.warning_amber_rounded,
            label: tr('vit_lvHigh'),
            title: tr('vit_riskHighTitle'),
            description: tr('vit_riskHighDesc'),
            active: risk.tier == 2,
          ),
          const SizedBox(height: 20),
          SectionLabel(tr('vit_categories')),
          const SizedBox(height: 10),
          _CategoryTile(
            icon: Icons.bedtime_outlined,
            accent: Etapa3Palette.blue,
            title: tr('vit_catSleep'),
            description: tr('vit_catSleepDesc'),
          ),
          const SizedBox(height: 10),
          _CategoryTile(
            icon: Icons.phone_android_outlined,
            accent: Etapa3Palette.cyan,
            title: tr('vit_catDevices'),
            description: tr('vit_catDevicesDesc'),
          ),
          const SizedBox(height: 10),
          _CategoryTile(
            icon: Icons.router_outlined,
            accent: Etapa3Palette.amber,
            title: tr('vit_catRouters'),
            description: tr('vit_catRoutersDesc'),
          ),
          const SizedBox(height: 10),
          _CategoryTile(
            icon: Icons.location_on_outlined,
            accent: Etapa3Palette.red,
            title: tr('vit_catZones'),
            description: tr('vit_catZonesDesc'),
          ),
          const SizedBox(height: 20),
          SectionLabel(tr('vit_tips')),
          const SizedBox(height: 10),
          _TipTile(
            impact: tr('vit_impactHigh'),
            color: Etapa3Palette.red,
            action: tr('vit_tip1'),
            reason: tr('vit_tip1Why'),
          ),
          const SizedBox(height: 10),
          _TipTile(
            impact: tr('vit_impactHigh'),
            color: Etapa3Palette.red,
            action: tr('vit_tip2'),
            reason: tr('vit_tip2Why'),
          ),
          const SizedBox(height: 10),
          _TipTile(
            impact: tr('vit_impactMid'),
            color: Etapa3Palette.amber,
            action: tr('vit_tip3'),
            reason: tr('vit_tip3Why'),
          ),
          const SizedBox(height: 10),
          _TipTile(
            impact: tr('vit_impactMid'),
            color: Etapa3Palette.amber,
            action: tr('vit_tip4'),
            reason: tr('vit_tip4Why'),
          ),
          const SizedBox(height: 10),
          _TipTile(
            impact: tr('vit_impactLow'),
            color: Etapa3Palette.green,
            action: tr('vit_tip5'),
            reason: tr('vit_tip5Why'),
          ),
        ],
      ),
    );
  }
}

/// The current health-risk tier, mapped from the backend radiation level.
class _RiskInfo {
  _RiskInfo(this.tier, this.label, this.title, this.description, this.summary,
      this.color, this.icon);

  final int tier; // 0 low, 1 moderate, 2 high
  final String label;
  final String title;
  final String description;
  final String summary;
  final Color color;
  final IconData icon;

  factory _RiskInfo.fromLevel(String? level) {
    switch (level) {
      case 'safe':
        return _RiskInfo(0, tr('vit_riskLow'), tr('vit_riskLowTitle'),
            tr('vit_riskLowDesc'), tr('vit_summaryLow'), Etapa3Palette.green,
            Icons.check_circle_outline);
      case 'danger':
        return _RiskInfo(2, tr('vit_riskHigh'), tr('vit_riskHighTitle'),
            tr('vit_riskHighDesc'), tr('vit_summaryHigh'), Etapa3Palette.red,
            Icons.warning_amber_rounded);
      case 'caution':
      default:
        return _RiskInfo(1, tr('vit_riskMod'), tr('vit_riskModTitle'),
            tr('vit_riskModDesc'), tr('vit_summaryMod'), Etapa3Palette.amber,
            Icons.info_outline);
    }
  }
}

class _CurrentRiskCard extends StatelessWidget {
  const _CurrentRiskCard({required this.risk});

  final _RiskInfo risk;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: risk.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: risk.color.withValues(alpha: 0.26)),
                ),
                child: Icon(risk.icon, color: risk.color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      risk.label,
                      style: TextStyle(
                        color: risk.color,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      risk.title,
                      style: const TextStyle(
                        color: Etapa3Palette.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            risk.summary,
            style: const TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskLevelRow extends StatelessWidget {
  const _RiskLevelRow({
    required this.color,
    required this.icon,
    required this.label,
    required this.title,
    required this.description,
    required this.active,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String title;
  final String description;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active ? 1.0 : 0.62,
      child: GlassPanel(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Etapa3Palette.text,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Etapa3Palette.muted,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            StatusPill(label: label, color: color),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.icon,
    required this.accent,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String description;

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
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 23),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
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
    );
  }
}

class _TipTile extends StatelessWidget {
  const _TipTile({
    required this.impact,
    required this.color,
    required this.action,
    required this.reason,
  });

  final String impact;
  final Color color;
  final String action;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusPill(label: impact, color: color),
          const SizedBox(height: 10),
          Text(
            action,
            style: const TextStyle(
              color: Etapa3Palette.text,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            reason,
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
