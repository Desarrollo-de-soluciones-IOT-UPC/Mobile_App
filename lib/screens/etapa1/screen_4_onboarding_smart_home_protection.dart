import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingSmartHomeProtectionScreen extends StatelessWidget {
  const OnboardingSmartHomeProtectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.shield,
      title: 'Smart Home Protection',
      description:
          'Integración completa con dispositivos inteligentes de tu hogar para máxima protección',
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProtectionFeature(
                    icon: Icons.camera_alt_outlined,
                    title: 'Cámaras Inteligentes',
                    description: 'Monitoreo 24/7',
                  ),
                  const SizedBox(height: 16),
                  _buildProtectionFeature(
                    icon: Icons.lock_outline,
                    title: 'Cerraduras Conectadas',
                    description: 'Control de acceso remoto',
                  ),
                  const SizedBox(height: 16),
                  _buildProtectionFeature(
                    icon: Icons.sensors_outlined,
                    title: 'Sensores Avanzados',
                    description: 'Detección de movimiento y más',
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
                  Navigator.of(context).pushNamed(AppRoutes.homeProfileSetup);
                },
                child: const Text('Continuar'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProtectionFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryBlue.withValues(alpha: 0.2),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryBlue,
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
                description,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

