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
      onSkip: () {
        Navigator.of(context).pushNamed(AppRoutes.onboardingFinalStep);
      },
      showBrandHeader: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 18),
            const Text(
              'Our advanced intelligence analyzes your environment to provide real-time safety protocols and energy optimization.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 26),
            _buildMediaCard(),
            const SizedBox(height: 26),
            const Text(
              'Get personalized recommendations with Astra AI.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Astra learns constantly to keep your home safe and energy-efficient without overwhelming you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.7,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(activeIndex: 1),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.onboardingSmartHomeProtection);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Next →'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCard() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryCyan.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                  center: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppTheme.darkBg,
              border: Border.all(color: AppTheme.primaryCyan.withValues(alpha: 0.3)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/IMG_ETAPA_1/AI_PHOTO.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 22,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.darkBg.withValues(alpha: 0.88),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Astra AI',
                style: TextStyle(
                  color: AppTheme.primaryCyan,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required int activeIndex}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool active = index == activeIndex;
        return Container(
          width: active ? 28 : 10,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryBlue : Colors.white12,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

