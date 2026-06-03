import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class HomeProfileSetupScreen extends StatelessWidget {
  const HomeProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double sidePadding = (24 * scale).clamp(16, 28);

    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      onSkip: () {
        Navigator.of(context).pushNamed(AppRoutes.onboardingFinalStep);
      },
      showBrandHeader: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: (18 * scale).clamp(12, 30)),
            Text(
              'Secure Your Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (32 * scale).clamp(24, 40),
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
            SizedBox(height: (14 * scale).clamp(10, 24)),
            Text(
              'Establish your primary monitoring zone to receive hyper-local radiation alerts and safety protocols.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: (15 * scale).clamp(13, 18),
                height: 1.8,
              ),
            ),
            SizedBox(height: (24 * scale).clamp(18, 44)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _buildLocationCard(scale: scale),
              ),
            ),
          ],
        ),
      ),
      footer: Padding(
        padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, sidePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(activeIndex: 2, scale: scale),
            SizedBox(height: (22 * scale).clamp(16, 32)),
            SizedBox(
              width: double.infinity,
              height: (56 * scale).clamp(46, 70),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.pairingSensors);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                ),
                child: Text(
                  'Next →',
                  style: TextStyle(
                    fontSize: (16 * scale).clamp(14, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard({required double scale}) {
    final double pad = (22 * scale).clamp(16, 28);
    final double radius = 28 * scale;

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMapSection(scale: scale),
          SizedBox(height: (22 * scale).clamp(16, 28)),
          Text(
            'Location Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: (16 * scale).clamp(14, 20),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: (18 * scale).clamp(12, 26)),
          _buildField(scale: scale, label: 'Street Address', value: '123 Guardian Way'),
          SizedBox(height: (14 * scale).clamp(10, 22)),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  scale: scale,
                  label: 'Suite / Apt',
                  value: 'Level 4',
                ),
              ),
              SizedBox(width: (14 * scale).clamp(10, 22)),
              Expanded(
                child: _buildField(
                  scale: scale,
                  label: 'ZIP Code',
                  value: '94103',
                ),
              ),
            ],
          ),
          SizedBox(height: (18 * scale).clamp(12, 26)),
          _buildProgressDetail(scale: scale),
        ],
      ),
    );
  }

  Widget _buildMapSection({required double scale}) {
    final double h = (170 * scale).clamp(130, 240);

    return Container(
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24 * scale),
        color: AppTheme.darkBg,
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all((16 * scale).clamp(10, 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18 * scale),
                  color: Colors.white.withValues(alpha: 0.03),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: AppTheme.primaryCyan.withValues(alpha: 0.9),
                    size: (36 * scale).clamp(24, 60),
                  ),
                ),
              ),
            ),
            SizedBox(height: (12 * scale).clamp(8, 22)),
            _buildStatusBar(scale: scale),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar({required double scale}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_pin,
                color: AppTheme.primaryCyan, size: (14 * scale).clamp(10, 20)),
            SizedBox(width: (8 * scale).clamp(4, 12)),
            Text(
              'Signal Locked',
              style: TextStyle(
                color: AppTheme.primaryCyan,
                fontSize: (13 * scale).clamp(10, 18),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: (10 * scale).clamp(6, 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Zone Alpha',
              style: TextStyle(
                color: Colors.white,
                fontSize: (20 * scale).clamp(16, 26),
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.gps_fixed,
              color: AppTheme.primaryCyan,
              size: (18 * scale).clamp(14, 26),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildField({
    required double scale,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: (12 * scale).clamp(10, 16),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: (8 * scale).clamp(6, 14)),
        Container(
          height: (52 * scale).clamp(40, 80),
          decoration: BoxDecoration(
            color: AppTheme.darkBg,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: (16 * scale).clamp(10, 24)),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: (15 * scale).clamp(12, 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDetail({required double scale}) {
    final double barW = (100 * scale).clamp(70, 140);
    final double barH = (8 * scale).clamp(6, 14);

    return Container(
      padding: EdgeInsets.all((14 * scale).clamp(10, 22)),
      decoration: BoxDecoration(
        color: AppTheme.darkBg,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearby Detectors',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: (12 * scale).clamp(10, 16),
                  ),
                ),
                SizedBox(height: (6 * scale).clamp(4, 12)),
                Text(
                  '8 Active',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: (13 * scale).clamp(10, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: barW,
            height: barH,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(99 * scale),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.78,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan,
                  borderRadius: BorderRadius.circular(99 * scale),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required int activeIndex, required double scale}) {
    final double activeW = (28 * scale).clamp(18, 44);
    final double inactiveW = (10 * scale).clamp(6, 20);
    final double h = (6 * scale).clamp(4, 10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool active = index == activeIndex;
        return Container(
          width: active ? activeW : inactiveW,
          height: h,
          margin: EdgeInsets.symmetric(horizontal: (4 * scale).clamp(2, 10)),
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryBlue : Colors.white12,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

