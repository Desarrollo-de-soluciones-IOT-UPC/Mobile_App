import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingSmartAlertsScreen extends StatelessWidget {
  const OnboardingSmartAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.notifications_active,
      title: 'Smart Alerts',
      description:
          'Recibe notificaciones inteligentes y en tiempo real sobre eventos importantes en tu hogar',
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
                  _buildFeatureItem(
                    icon: Icons.bolt,
                    title: 'Alertas Instantáneas',
                    description: 'Notificaciones en tiempo real',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.tune,
                    title: 'Personalizables',
                    description: 'Configura según tus necesidades',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.shield_outlined,
                    title: 'Seguridad Total',
                    description: 'Protección completa de tu hogar',
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
                  Navigator.of(context)
                      .pushNamed(AppRoutes.onboardingAstraAssistant);
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

  Widget _buildFeatureItem({
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
            color: AppTheme.primaryCyan.withValues(alpha: 0.2),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryCyan,
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

