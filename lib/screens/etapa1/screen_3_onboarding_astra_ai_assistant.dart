import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../routes/etapa2_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class OnboardingAstraAIAssistantScreen extends StatelessWidget {
  const OnboardingAstraAIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double sidePadding = (24 * scale).clamp(16, 28);
    final double topGap = (18 * scale).clamp(12, 32);

    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      onSkip: () {
        Navigator.of(context).pushNamed(Etapa2Routes.personalDetails);
      },
      showBrandHeader: false,
      footer: Padding(
        padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, sidePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(activeIndex: 1, scale: scale),
            SizedBox(height: (22 * scale).clamp(16, 30)),
            SizedBox(
              width: double.infinity,
              height: (56 * scale).clamp(46, 70),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.onboardingSmartHomeProtection);
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: topGap),
            Text(
              'Our advanced intelligence analyzes your environment to provide real-time safety protocols and energy optimization.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: (15 * scale).clamp(13, 18),
                height: 1.8,
              ),
            ),
            SizedBox(height: (26 * scale).clamp(18, 40)),
            _buildMediaCard(scale: scale),
            SizedBox(height: (26 * scale).clamp(18, 40)),
            Text(
              'Get personalized recommendations with Astra AI.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (18 * scale).clamp(16, 22),
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            SizedBox(height: (14 * scale).clamp(10, 24)),
            Text(
              'Astra learns constantly to keep your home safe and energy-efficient without overwhelming you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: (14 * scale).clamp(12, 18),
                height: 1.7,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCard({required double scale}) {
    final double cardW = (342 * scale).clamp(260, 420);
    final double outerH = (342 * scale).clamp(240, 420);
    final double avatarSize = (286 * scale).clamp(220, 390);

    return Center(
      child: Container(
        width: cardW,
        height: outerH + (48 * scale).clamp(30, 80),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(28 * scale),
          border: Border.all(color: AppTheme.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: (18 * scale).clamp(10, 30),
              offset: Offset(0, (8 * scale).clamp(4, 16).toDouble()),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Radial gradient background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28 * scale),
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

            // Avatar/overlay+border+shadow
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28 * scale),
                color: AppTheme.darkBg,
                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28 * scale),
                child: Image.asset(
                  'assets/IMG_ETAPA_1/AI_PHOTO.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Small caption pill
            Positioned(
              bottom: (22 * scale).clamp(14, 34),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: (16 * scale).clamp(12, 24),
                  vertical: (10 * scale).clamp(8, 16),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.darkBg.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
                child: Text(
                  'Astra AI',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: (14 * scale).clamp(12, 18),
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

  Widget _buildProgressBar({required int activeIndex, required double scale}) {
    final double activeW = (40 * scale).clamp(24, 50);
    final double inactiveW = (8 * scale).clamp(6, 16);
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
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.45),
                      blurRadius: (10 * scale).clamp(6, 16),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
