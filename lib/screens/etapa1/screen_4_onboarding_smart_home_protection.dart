import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingSmartHomeProtectionScreen extends StatelessWidget {
  const OnboardingSmartHomeProtectionScreen({super.key});

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
                  Navigator.of(context).pushNamed(AppRoutes.homeProfileSetup);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                ),
                child: Text(
                  'Get Started →',
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
            SizedBox(height: (18 * scale).clamp(12, 30)),
            _buildHeroBentoGrid(scale: scale),
            SizedBox(height: (22 * scale).clamp(16, 34)),
            Text(
              'Protect your devices and smart home automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (26 * scale).clamp(20, 32),
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: (14 * scale).clamp(10, 24)),
            Text(
              'Advanced AI monitoring shields every connection, ensuring your digital life remains private and secure without lifting a finger.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: (15 * scale).clamp(13, 17),
                height: 1.5,
              ),
            ),
            SizedBox(height: (24 * scale).clamp(16, 40)),
            _buildFeatureBadges(scale: scale),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBentoGrid({required double scale}) {
    final double gridHeight = (320 * scale).clamp(260, 380);

    return SizedBox(
      height: gridHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: _bentoCard(
                    child: Icon(
                      Icons.tv,
                      color: Colors.white38,
                      size: 28 * scale,
                    ),
                  ),
                ),
                SizedBox(height: 10 * scale),
                Expanded(
                  flex: 6,
                  child: _bentoCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.gamepad_outlined,
                          color: Colors.white38,
                          size: 24 * scale,
                        ),
                        Text(
                          'MONITORED',
                          style: TextStyle(
                            color: AppTheme.primaryBlue,
                            fontSize: (10 * scale).clamp(9, 14),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            flex: 5,
            child: _bentoCard(
              borderColor: AppTheme.primaryBlue.withValues(alpha: 0.25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(14 * scale),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                    child: Icon(
                      Icons.router,
                      color: AppTheme.primaryBlue,
                      size: 32 * scale,
                    ),
                  ),
                  SizedBox(height: 14 * scale),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10 * scale,
                      vertical: 4 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20 * scale),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 3 * scale,
                          backgroundColor: AppTheme.primaryBlue,
                        ),
                        SizedBox(width: 6 * scale),
                        Text(
                          'OPTIMIZED',
                          style: TextStyle(
                            color: AppTheme.primaryBlue,
                            fontSize: (10 * scale).clamp(9, 14),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: _bentoCard(
                    child: Icon(
                      Icons.videocam_outlined,
                      color: Colors.white38,
                      size: 24 * scale,
                    ),
                  ),
                ),
                SizedBox(height: 10 * scale),
                Expanded(
                  flex: 6,
                  child: _bentoCard(
                    child: Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white38,
                      size: 24 * scale,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bentoCard({required Widget child, Color? borderColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? Colors.white10, width: 1.5),
      ),
      child: child,
    );
  }

  Widget _buildFeatureBadges({required double scale}) {
    return Row(
      children: [
        Expanded(
          child: _featureCard(
            icon: Icons.auto_awesome_outlined,
            title: 'AUTO-SHIELD',
            scale: scale,
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: _featureCard(
            icon: Icons.shield_outlined,
            title: 'PRIVACY+',
            scale: scale,
          ),
        ),
      ],
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required double scale,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14 * scale,
        horizontal: 16 * scale,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 20 * scale),
          SizedBox(width: 10 * scale),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: (12 * scale).clamp(10, 16),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1 * scale,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required int activeIndex, required double scale}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool active = index == activeIndex;
        return Container(
          width: active ? 28 * scale : 10 * scale,
          height: 6 * scale,
          margin: EdgeInsets.symmetric(horizontal: 4 * scale),
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryBlue : Colors.white12,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
