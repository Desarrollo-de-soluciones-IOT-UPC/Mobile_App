import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingSmartAlertsScreen extends StatelessWidget {
  const OnboardingSmartAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = (size.width / 390).clamp(0.85, 1.15);

    final double sidePadding = (24 * scale).clamp(16, 28);
    final double titleFont = (32 * scale).clamp(22, 38);
    final double bodyFont = (15 * scale).clamp(13, 18);

    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      onSkip: () {
        Navigator.of(context).pushNamed(AppRoutes.onboardingFinalStep);
      },
      footer: Padding(
        padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, sidePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(activeIndex: 0, scale: scale),
            SizedBox(height: (22 * scale).clamp(16, 28)),
            SizedBox(
              width: double.infinity,
              height: (56 * scale).clamp(46, 70),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.onboardingAstraAssistant);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16 * scale.clamp(0.85, 1.15),
                    ),
                  ),
                ),
                child: Text(
                  'Next',
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAlertCard(context, scale: scale),
            SizedBox(height: (28 * scale).clamp(18, 40)),
            Text(
              'Receive alerts before radiation becomes dangerous.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFont,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
            SizedBox(height: (16 * scale).clamp(12, 24)),
            Text(
              'EmSafe continuously monitors your environment and provides smart, actionable recommendations to minimize EMF exposure.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: bodyFont,
                height: 1.8,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, {required double scale}) {
    final double pad = (22 * scale).clamp(16, 28);
    final double radius = (24 * scale).clamp(18, 32);
    final double iconSize = (46 * scale).clamp(36, 60);
    final double iconRadius = (14 * scale).clamp(10, 20);

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(iconRadius),
                  color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                ),
                child: Icon(
                  Icons.router_outlined,
                  color: AppTheme.primaryBlue,
                  size: (22 * scale).clamp(18, 30),
                ),
              ),
              SizedBox(width: (16 * scale).clamp(12, 22)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Living Room Router',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (16 * scale).clamp(14, 20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: (4 * scale).clamp(2, 10)),
                    Row(
                      children: [
                        Text(
                          'WARNING: ',
                          style: TextStyle(
                            color: AppTheme.warningOrange,
                            fontSize: (12 * scale).clamp(11, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'RADIATION SPIKE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: (12 * scale).clamp(11, 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'NOW',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: (12 * scale).clamp(11, 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: (18 * scale).clamp(12, 26)),
          Text(
            'High EMF emissions detected. Consider moving the router at least 2 meters away from high-occupancy areas.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: (14 * scale).clamp(12, 18),
              height: 1.7,
            ),
          ),
          SizedBox(height: (22 * scale).clamp(16, 28)),
          SizedBox(
            width: double.infinity,
            height: (46 * scale).clamp(40, 56),
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.warningOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14 * scale),
                ),
              ),
              child: Text(
                'Optimize Location',
                style: TextStyle(
                  fontSize: (12.5 * scale).clamp(12, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required int activeIndex, required double scale}) {
    final double activeW = (28 * scale).clamp(16, 40);
    final double inactiveW = (10 * scale).clamp(6, 20);
    final double h = (6 * scale).clamp(4, 10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool active = index == activeIndex;
        return Container(
          width: active ? activeW : inactiveW,
          height: h,
          margin: EdgeInsets.symmetric(horizontal: (4 * scale).clamp(2, 8)),
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryBlue : Colors.white12,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
