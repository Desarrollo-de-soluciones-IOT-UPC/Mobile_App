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
      onSkip: () {
        Navigator.of(context).pushNamed(AppRoutes.onboardingFinalStep);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAlertCard(context),
            const SizedBox(height: 32),
            Text(
              'Receive alerts before radiation becomes dangerous.',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'EmSafe continuously monitors your environment and provides smart, actionable recommendations to minimize EMF exposure.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.8,
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
            _buildProgressBar(activeIndex: 0),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.onboardingAstraAssistant);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                ),
                child: const Icon(
                  Icons.router_outlined,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Living Room Router',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Text(
                          'WARNING: ',
                          style: TextStyle(
                            color: AppTheme.warningOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'RADIATION SPIKE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text(
                'NOW',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'High EMF emissions detected. Consider moving the router at least 2 meters away from high-occupancy areas.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.warningOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Optimize Location'),
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

