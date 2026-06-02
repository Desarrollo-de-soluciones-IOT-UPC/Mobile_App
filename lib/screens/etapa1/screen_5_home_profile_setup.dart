import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class HomeProfileSetupScreen extends StatelessWidget {
  const HomeProfileSetupScreen({super.key});

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
              'Secure Your Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Establish your primary monitoring zone to receive hyper-local radiation alerts and safety protocols.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 24),
            _buildLocationCard(),
            const Spacer(),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(activeIndex: 2),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.pairingSensors);
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

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMapSection(),
          const SizedBox(height: 22),
          const Text(
            'Location Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          _buildField('Street Address', '123 Guardian Way'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _buildField('Suite / Apt', 'Level 4')),
              const SizedBox(width: 14),
              Expanded(child: _buildField('ZIP Code', '94103')),
            ],
          ),
          const SizedBox(height: 18),
          _buildProgressDetail(),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppTheme.darkBg,
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withValues(alpha: 0.03),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: AppTheme.primaryCyan.withValues(alpha: 0.9),
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildStatusBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.location_pin, color: AppTheme.primaryCyan, size: 14),
            SizedBox(width: 8),
            Text(
              'Signal Locked',
              style: TextStyle(
                color: AppTheme.primaryCyan,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Zone Alpha',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.gps_fixed,
              color: AppTheme.primaryCyan,
              size: 18,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppTheme.darkBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDetail() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.darkBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearby Detectors',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '8 Active',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(99),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.78,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan,
                  borderRadius: BorderRadius.circular(99),
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

