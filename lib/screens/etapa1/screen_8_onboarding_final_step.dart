import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingFinalStepScreen extends StatelessWidget {
  const OnboardingFinalStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.check_circle,
      title: '¡Listo!',
      description: 'Tu sistema de protección está configurado completamente',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.darkBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.successGreen.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompletionItem(
                    icon: Icons.home,
                    title: 'Hogar Configurado',
                    status: 'Completado',
                  ),
                  const SizedBox(height: 16),
                  _buildCompletionItem(
                    icon: Icons.sensors,
                    title: 'Sensores Emparejados',
                    status: 'Conectados',
                  ),
                  const SizedBox(height: 16),
                  _buildCompletionItem(
                    icon: Icons.security,
                    title: 'Protección Activa',
                    status: 'En línea',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.splash1,
                    (route) => false,
                  );
                },
                child: const Text('Ir al Inicio'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionItem({
    required IconData icon,
    required String title,
    required String status,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.successGreen.withValues(alpha: 0.2),
          ),
          child: Icon(
            icon,
            color: AppTheme.successGreen,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: AppTheme.successGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.verified,
          color: AppTheme.successGreen,
          size: 24,
        ),
      ],
    );
  }
}

