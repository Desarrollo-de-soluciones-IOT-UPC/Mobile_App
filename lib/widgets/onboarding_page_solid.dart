import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Wrapper mejorado para pantallas onboarding.
/// - background: color base
/// - showBrandHeader: muestra el header superior con logo + Skip
/// - child: widgets nativos (contenido de la pantalla)
/// - footer: widget fijo en la parte inferior (botón, indicadores)
class OnboardingPageSolid extends StatelessWidget {
  final Color background;
  final Widget child;
  final bool showBrandHeader;
  final VoidCallback? onSkip;
  final Widget? footer;

  const OnboardingPageSolid({
    super.key,
    required this.background,
    required this.child,
    this.showBrandHeader = true,
    this.onSkip,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            if (showBrandHeader)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppTheme.darkBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.security,
                            color: AppTheme.primaryCyan,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'EmSafe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (onSkip != null)
                      TextButton(
                        onPressed: onSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Skip'),
                      ),
                  ],
                ),
              ),
            Expanded(
              child: child,
            ),
            if (footer != null) ...[footer!],
          ],
        ),
      ),
    );
  }
}

