import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class PairingSensorsScreen extends StatefulWidget {
  const PairingSensorsScreen({super.key});

  @override
  State<PairingSensorsScreen> createState() => _PairingSensorsScreenState();
}

class _PairingSensorsScreenState extends State<PairingSensorsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _radarController;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double sidePadding = (16 * scale).clamp(12, 22);
    final double titleFont = (24 * scale).clamp(18, 32);
    final double bodyFont = (16 * scale).clamp(13, 18);

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
            SizedBox(
              width: double.infinity,
              height: (56 * scale).clamp(46, 70),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.pairYourSensor);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                ),
                child: Text(
                  'Pair Device',
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
            SizedBox(height: (10 * scale).clamp(6, 18)),
            Text(
              'Searching for Sensors',

              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFont,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(height: (8 * scale).clamp(6, 16)),
            Text(
              'Ensure your device is powered and nearby.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: bodyFont,
                height: 1.6,
              ),
            ),
            SizedBox(height: (24 * scale).clamp(16, 40)),
            _buildRadar(scale: scale),
            SizedBox(height: (16 * scale).clamp(10, 30)),
            _buildStatus(scale: scale),
            SizedBox(height: (18 * scale).clamp(10, 30)),
            Expanded(child: _buildDeviceCard(scale: scale)),
          ],
        ),
      ),
    );
  }

  Widget _buildRadar({required double scale}) {
    final double pulse = (280 * scale).clamp(200, 360);
    final double radarBox = (326.22 * scale).clamp(260, 420);

    return SizedBox(
      height: radarBox,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glows
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all((1 * scale).clamp(0.5, 6)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: null,
            ),
          ),

          // Radar pulse ring
          RotationTransition(
            turns: _radarController,
            child: Container(
              width: pulse,
              height: pulse,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                borderRadius: null,

                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.25),
                  width: 2,
                ),
              ),
            ),
          ),

          // Center icon
          Container(
            width: (80 * scale).clamp(64, 120),
            height: (80 * scale).clamp(64, 120),
            decoration: BoxDecoration(
              color: const Color(0xFF00C0E9).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(
                color: AppTheme.primaryCyan.withValues(alpha: 0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                  blurRadius: (40 * scale).clamp(20, 60),
                ),
              ],
            ),
            child: Icon(
              Icons.sensors,
              size: (34 * scale).clamp(26, 52),
              color: AppTheme.primaryCyan,
            ),
          ),

          // Floating dots
          Positioned(
            right: (40 * scale).clamp(20, 60),
            top: (16 * scale).clamp(8, 30),
            child: _dot(
              scale: scale,
              color: AppTheme.primaryCyan.withValues(alpha: 1),
            ),
          ),
          Positioned(
            left: (24 * scale).clamp(10, 40),
            bottom: (48 * scale).clamp(20, 60),
            child: _dot(
              scale: scale,
              color: AppTheme.primaryCyan.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot({required double scale, required Color color}) {
    final double s = (8 * scale).clamp(5, 14);
    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: color, blurRadius: (8 * scale).clamp(6, 18)),
        ],
      ),
    );
  }

  Widget _buildStatus({required double scale}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (8 * scale).clamp(6, 14),
              height: (8 * scale).clamp(6, 14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF65DAFF),
              ),
            ),
            SizedBox(width: (8 * scale).clamp(4, 14)),
            Text(
              'LIVE SCAN ACTIVE',
              style: TextStyle(
                color: AppTheme.primaryCyan,
                fontSize: (12 * scale).clamp(10, 16),
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0 * scale,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeviceCard({required double scale}) {
    return Container(
      margin: EdgeInsets.only(bottom: (8 * scale).clamp(0, 12)),
      padding: EdgeInsets.all((24 * scale).clamp(16, 32)),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F28).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(color: AppTheme.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: (32 * scale).clamp(18, 60),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMSafe S1 Hub detected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (20 * scale).clamp(16, 24),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: (8 * scale).clamp(4, 14)),
                    Text(
                      'Secure Protocol',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: (14 * scale).clamp(12, 18),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryCyan,
                size: (24 * scale).clamp(18, 34),
              ),
            ],
          ),
          SizedBox(height: (16 * scale).clamp(10, 28)),
          Divider(color: Colors.white10),
          SizedBox(height: (12 * scale).clamp(6, 18)),
          _infoBar(scale: scale),
        ],
      ),
    );
  }

  Widget _infoBar({required double scale}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Signal Strength',
              style: TextStyle(
                color: Colors.white54,
                fontSize: (14 * scale).clamp(12, 18),
              ),
            ),
            Text(
              'Excellent',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: (14 * scale).clamp(12, 18),
              ),
            ),
          ],
        ),
        SizedBox(height: (12 * scale).clamp(6, 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Firmware',
              style: TextStyle(
                color: Colors.white54,
                fontSize: (14 * scale).clamp(12, 18),
              ),
            ),
            Text(
              'v2.4.0 Stable',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: (14 * scale).clamp(12, 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
