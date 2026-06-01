import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Wrapper mejorado para pantallas onboarding.
/// - background: color base
/// - isDark: usa tema oscuro o claro
/// - icon: ícono opcional a mostrar en la parte superior
/// - title: título principal
/// - description: descripción opcional
/// - child: widgets nativos (buttons, inputs, etc.)
class OnboardingPageSolid extends StatelessWidget {
  final Color background;
  final Widget child;
  final IconData? icon;
  final String? title;
  final String? description;
  final bool isDark;

  const OnboardingPageSolid({
    super.key,
    required this.background,
    required this.child,
    this.icon,
    this.title,
    this.description,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // Header opcional con ícono y títulos
            if (icon != null || title != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    if (icon != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? AppTheme.darkBg
                              : Colors.grey.shade200,
                        ),
                        child: Icon(
                          icon,
                          size: 40,
                          color: isDark
                              ? AppTheme.primaryCyan
                              : AppTheme.primaryBlue,
                        ),
                      ),
                    if (icon != null) const SizedBox(height: 20),
                    if (title != null)
                      Text(
                        title!,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: isDark
                                      ? AppTheme.primaryCyan
                                      : AppTheme.darkNavy,
                                  fontSize: 28,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    if (description != null) const SizedBox(height: 12),
                    if (description != null)
                      Text(
                        description!,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),

            // Contenido flexible
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

