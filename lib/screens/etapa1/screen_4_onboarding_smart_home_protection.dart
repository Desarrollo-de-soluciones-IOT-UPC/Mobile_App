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
            _buildConnectedSystem(),
            const SizedBox(height: 26),
            const Text(
              'Protect your devices and smart home automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Advanced AI monitoring shields every connection, ensuring your digital life remains private and secure without lifting a finger.',
              textAlign: TextAlign.center,
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
            _buildBadgeRow(),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.homeProfileSetup);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Get Started →'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedSystem() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _smallDeviceCard(icon: Icons.desktop_windows),
              const SizedBox(width: 10),
              _smallDeviceCard(icon: Icons.videocam),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppTheme.darkBg,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.router_outlined,
                      color: AppTheme.primaryBlue,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'OPTIMIZED',
                    style: TextStyle(
                      color: AppTheme.primaryBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _smallDeviceCard(icon: Icons.gamepad)),
              const SizedBox(width: 10),
              Expanded(child: _smallDeviceCard(icon: Icons.lightbulb_outline)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallDeviceCard({required IconData icon}) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.darkBg,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white70,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildBadgeRow() {
    return Row(
      children: [
        Expanded(child: _buildBadge('AUTO-SHIELD')),
        const SizedBox(width: 12),
        Expanded(child: _buildBadge('PRIVACY+')),
      ],
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppTheme.darkBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

