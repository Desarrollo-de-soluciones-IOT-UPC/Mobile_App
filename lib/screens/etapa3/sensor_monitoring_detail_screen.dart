import 'package:flutter/material.dart';

import 'etapa3_components.dart';

enum _HealthRiskLevel { low, moderate, high }

class _HealthRiskInfo {
  const _HealthRiskInfo({
    required this.level,
    required this.label,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  final _HealthRiskLevel level;
  final String label;
  final String title;
  final String description;
  final Color color;
  final IconData icon;
}

class _RiskCategory {
  const _RiskCategory({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color accent;
}

class _HealthTip {
  const _HealthTip({
    required this.impact,
    required this.action,
    required this.reason,
    required this.color,
  });

  final String impact;
  final String action;
  final String reason;
  final Color color;
}

class _HealthTipsMock {
  const _HealthTipsMock({
    required this.currentRisk,
    required this.summary,
    required this.riskLevels,
    required this.categories,
    required this.tips,
  });

  final _HealthRiskInfo currentRisk;
  final String summary;
  final List<_HealthRiskInfo> riskLevels;
  final List<_RiskCategory> categories;
  final List<_HealthTip> tips;

  static const current = _HealthTipsMock(
    currentRisk: _HealthRiskInfo(
      level: _HealthRiskLevel.moderate,
      label: 'Riesgo moderado',
      title: 'Tomar precauciones',
      description:
          'Hay exposición frecuente en tu entorno. Pequeños cambios diarios pueden reducir el riesgo.',
      color: Etapa3Palette.amber,
      icon: Icons.info_outline,
    ),
    summary:
        'Tu entorno presenta un nivel moderado de exposición. Revisa estas recomendaciones para disminuir el riesgo.',
    riskLevels: [
      _HealthRiskInfo(
        level: _HealthRiskLevel.low,
        label: 'Bajo',
        title: 'Exposición controlada',
        description:
            'Mantener hábitos preventivos y revisar alertas ocasionales.',
        color: Etapa3Palette.green,
        icon: Icons.check_circle_outline,
      ),
      _HealthRiskInfo(
        level: _HealthRiskLevel.moderate,
        label: 'Medio',
        title: 'Tomar precauciones',
        description: 'Reducir cercanía a fuentes activas y alternar descansos.',
        color: Etapa3Palette.amber,
        icon: Icons.shield_outlined,
      ),
      _HealthRiskInfo(
        level: _HealthRiskLevel.high,
        label: 'Alto',
        title: 'Reducir exposición',
        description: 'Alejarse de fuentes cercanas y revisar zonas frecuentes.',
        color: Etapa3Palette.red,
        icon: Icons.warning_amber_rounded,
      ),
    ],
    categories: [
      _RiskCategory(
        icon: Icons.bedtime_outlined,
        title: 'Sueño y descanso',
        description:
            'Dormir con el celular muy cerca puede aumentar la exposición durante varias horas seguidas.',
        accent: Etapa3Palette.blue,
      ),
      _RiskCategory(
        icon: Icons.phone_android_outlined,
        title: 'Uso prolongado de dispositivos',
        description:
            'Usar equipos sin pausas mantiene la exposición cerca del cuerpo por más tiempo.',
        accent: Etapa3Palette.cyan,
      ),
      _RiskCategory(
        icon: Icons.router_outlined,
        title: 'Routers y fuentes cercanas',
        description:
            'Permanecer junto a routers o equipos activos puede elevar la exposición diaria.',
        accent: Etapa3Palette.amber,
      ),
      _RiskCategory(
        icon: Icons.location_on_outlined,
        title: 'Zonas de mayor radiación',
        description:
            'Algunas zonas frecuentes pueden acumular lecturas más altas que otras durante el día.',
        accent: Etapa3Palette.red,
      ),
    ],
    tips: [
      _HealthTip(
        impact: 'Alto impacto',
        action: 'Mantén el celular alejado mientras duermes.',
        reason: 'Reduce varias horas de exposición cercana durante la noche.',
        color: Etapa3Palette.red,
      ),
      _HealthTip(
        impact: 'Alto impacto',
        action: 'Evita permanecer mucho tiempo cerca del router.',
        reason: 'Alejarte unos metros disminuye la exposición continua.',
        color: Etapa3Palette.red,
      ),
      _HealthTip(
        impact: 'Medio impacto',
        action:
            'Reduce el uso continuo de dispositivos cuando el nivel sea alto.',
        reason: 'Las pausas ayudan a limitar el tiempo total de exposición.',
        color: Etapa3Palette.amber,
      ),
      _HealthTip(
        impact: 'Medio impacto',
        action: 'Revisa las alertas de exposición en zonas frecuentes.',
        reason:
            'Identificar patrones permite tomar mejores decisiones diarias.',
        color: Etapa3Palette.amber,
      ),
      _HealthTip(
        impact: 'Bajo impacto',
        action: 'Activa recordatorios o pausas preventivas.',
        reason: 'Pequeños hábitos sostenidos ayudan a mantener el riesgo bajo.',
        color: Etapa3Palette.green,
      ),
    ],
  );
}

class SensorMonitoringDetailScreen extends StatelessWidget {
  const SensorMonitoringDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tipsData = _HealthTipsMock.current;

    return Etapa3Shell(
      title: 'Salud Electromagnética',
      subtitle: 'Aprende a reducir tu exposición diaria y cuida tu bienestar.',
      selectedIndex: 1,
      child: const _HealthTipsContent(data: tipsData),
    );
  }
}

class _HealthTipsContent extends StatelessWidget {
  const _HealthTipsContent({required this.data});

  final _HealthTipsMock data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RiskHero(risk: data.currentRisk),
        const SizedBox(height: 18),
        _SummaryCard(summary: data.summary, color: data.currentRisk.color),
        const SizedBox(height: 20),
        const SectionLabel('NIVELES DE RIESGO'),
        const SizedBox(height: 10),
        _RiskLevelWrap(levels: data.riskLevels),
        const SizedBox(height: 20),
        const SectionLabel('CATEGORIAS DE RIESGO'),
        const SizedBox(height: 10),
        _RiskCategoryGrid(categories: data.categories),
        const SizedBox(height: 20),
        const SectionLabel('RECOMENDACIONES PRIORIZADAS'),
        const SizedBox(height: 10),
        for (final tip in data.tips) ...[
          _TipCard(tip: tip),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _RiskHero extends StatelessWidget {
  const _RiskHero({required this.risk});

  final _HealthRiskInfo risk;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: risk.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: risk.color.withValues(alpha: 0.24)),
                ),
                child: Icon(risk.icon, color: risk.color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nivel actual',
                      style: TextStyle(
                        color: Etapa3Palette.quiet,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      risk.label,
                      style: TextStyle(
                        color: risk.color,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            risk.title,
            style: const TextStyle(
              color: Etapa3Palette.text,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            risk.description,
            style: const TextStyle(
              color: Etapa3Palette.muted,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: _riskProgress(risk.level),
              minHeight: 8,
              backgroundColor: const Color(0xFF32343E),
              valueColor: AlwaysStoppedAnimation<Color>(risk.color),
            ),
          ),
        ],
      ),
    );
  }

  double _riskProgress(_HealthRiskLevel level) {
    switch (level) {
      case _HealthRiskLevel.low:
        return 0.32;
      case _HealthRiskLevel.moderate:
        return 0.64;
      case _HealthRiskLevel.high:
        return 0.92;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary, required this.color});

  final String summary;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.health_and_safety_outlined, color: color, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              summary,
              style: const TextStyle(
                color: Etapa3Palette.text,
                fontSize: 14,
                height: 1.45,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskLevelWrap extends StatelessWidget {
  const _RiskLevelWrap({required this.levels});

  final List<_HealthRiskInfo> levels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final level in levels) ...[
          _RiskLevelCard(level: level),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _RiskLevelCard extends StatelessWidget {
  const _RiskLevelCard({required this.level});

  final _HealthRiskInfo level;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          StatusPill(label: level.label, color: level.color, icon: level.icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level.title,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  level.description,
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

class _RiskCategoryGrid extends StatelessWidget {
  const _RiskCategoryGrid({required this.categories});

  final List<_RiskCategory> categories;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        return GridView.count(
          crossAxisCount: compact ? 1 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: compact ? 2.15 : 0.82,
          children: [
            for (final category in categories)
              _RiskCategoryCard(category: category),
          ],
        );
      },
    );
  }
}

class _RiskCategoryCard extends StatelessWidget {
  const _RiskCategoryCard({required this.category});

  final _RiskCategory category;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: category.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: category.accent.withValues(alpha: 0.22),
              ),
            ),
            child: Icon(category.icon, color: category.accent, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            category.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Etapa3Palette.text,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              category.description,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Etapa3Palette.muted,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip});

  final _HealthTip tip;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tip.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tip.color.withValues(alpha: 0.22)),
            ),
            child: Icon(Icons.task_alt, color: tip.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusPill(label: tip.impact, color: tip.color),
                const SizedBox(height: 10),
                Text(
                  tip.action,
                  style: const TextStyle(
                    color: Etapa3Palette.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tip.reason,
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
