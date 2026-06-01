import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingAstraAIAssistantScreen extends StatelessWidget {
  const OnboardingAstraAIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.smart_toy_outlined,
      title: 'Astra AI Assistant',
      description:
          'Tu asistente inteligente que aprende tus patrones y te ayuda a proteger tu hogar',
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
                  color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCapabilityItem(
                    icon: Icons.psychology,
                    title: 'Aprendizaje Automático',
                    description: 'Se adapta a tu estilo de vida',
                  ),
                  const SizedBox(height: 16),
                  _buildCapabilityItem(
                    icon: Icons.language,
                    title: 'Comandos de Voz',
                    description: 'Controla con tu voz',
                  ),
                  const SizedBox(height: 16),
                  _buildCapabilityItem(
                    icon: Icons.trending_up,
                    title: 'Análisis Predictivo',
                    description: 'Anticipa problemas potenciales',
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
                      .pushNamed(AppRoutes.onboardingSmartHomeProtection);
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

  Widget _buildCapabilityItem({
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

