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
      onSkip: () {
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.splash1, (route) => false);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppTheme.darkBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: const Icon(
                  Icons.shield,
                  size: 40,
                  color: AppTheme.primaryCyan,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Your environment, secured.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 24),
            _buildResultCard(),
            const Spacer(),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.splash1, (route) => false);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Start Monitoring'),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeatureRow(
            icon: Icons.shield,
            title: 'Setup Complete',
            subtitle: 'Your protective shield is active.',
          ),
          const SizedBox(height: 16),
          _buildFeatureRow(
            icon: Icons.analytics,
            title: 'Real-time Vitals',
            subtitle: 'Continuous biometric monitoring for early warning.',
          ),
          const SizedBox(height: 16),
          _buildFeatureRow(
            icon: Icons.network_wifi,
            title: 'Adaptive Mesh',
            subtitle: 'Seamless connection between all your smart sensors.',
          ),
          const SizedBox(height: 16),
          _buildFeatureRow(
            icon: Icons.notifications_active,
            title: 'Instant Alerts',
            subtitle: 'Critical notifications even when your device is on silent.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primaryCyan.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryCyan,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

