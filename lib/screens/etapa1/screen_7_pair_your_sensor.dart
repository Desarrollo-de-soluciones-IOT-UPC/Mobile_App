import 'dart:ui';

import 'package:flutter/material.dart';


import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

/// POPUP sobre la pantalla de Pairing Sensors.
/// Mantiene el diseño escalado con el mismo `scale` que el resto de onboarding.
class PairYourSensorScreen extends StatelessWidget {
  const PairYourSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double sidePadding = (24 * scale).clamp(16, 28);
    final double overlayRadius = 8 * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dimmer
          Positioned.fill(
            child: Container(
              color: const Color.fromRGBO(16, 19, 27, 0.6),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: const SizedBox.expand(),
              ),
            ),
          ),

          // Popup
          Center(
            child: Container(
              width: (358 * scale).clamp(280, 420),
              height: (664 * scale).clamp(520, 720),
              decoration: BoxDecoration(
                color: AppTheme.cardBg.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(overlayRadius),
                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(overlayRadius),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.002),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all((32 * scale).clamp(16, 40)),
                    child: Column(
                      children: [
                        _buildTopHeader(scale: scale),
                        SizedBox(height: (20 * scale).clamp(10, 30)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildIoTIcon(scale: scale),
                              SizedBox(height: (16 * scale).clamp(10, 26)),
                              _buildTitleAndCopy(scale: scale),
                              SizedBox(height: (16 * scale).clamp(10, 26)),
                              _buildPrimaryButton(context, scale: scale),

                              SizedBox(height: (10 * scale).clamp(8, 16)),
        _buildSecondaryRow(scale: scale),
      

                            ],
                          ),
                        ),
                        SizedBox(height: (8 * scale).clamp(4, 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader({required double scale}) {
    // En el CSS el header es parte del overlay. Lo representamos como un mini bar.
    return Row(
      children: [
        _HeaderLeft(scale: scale),
        const Spacer(),
        _HeaderRightClose(scale),
      ],
    );
  }

  Widget _buildIoTIcon({required double scale}) {
    final double iconOuter = (128 * scale).clamp(96, 170);
    return Container(
      width: iconOuter,
      height: iconOuter,
      decoration: BoxDecoration(
        color: AppTheme.primaryCyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: AppTheme.primaryCyan.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: (96 * scale).clamp(70, 140),
              height: (96 * scale).clamp(70, 140),
              decoration: BoxDecoration(
                color: const Color(0xFF32343E),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.55)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                    blurRadius: (20 * scale).clamp(10, 40),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: (36 * scale).clamp(26, 70),
                  height: (40 * scale).clamp(28, 75),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(8 * scale),
                  ),
                  child: const Icon(Icons.sensors, color: Color(0xFF0B0E16)),
                ),
              ),
            ),
            Positioned(
              right: (-8 * scale).clamp(-16, -4),
              bottom: (-8 * scale).clamp(-16, -4),
              child: Container(
                width: (48 * scale).clamp(36, 90),
                height: (48 * scale).clamp(36, 90),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(
                    width: (4 * scale).clamp(2, 8),
                    color: const Color(0xFF10131B),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: (16.3 * scale).clamp(10, 30),
                    height: (12.02 * scale).clamp(8, 28),
                    decoration: const BoxDecoration(
                      color: Color(0xFF002B73),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndCopy({required double scale}) {
    return Column(
      children: [
        Text(
          'CONNECTED',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (40 * scale).clamp(26, 56),
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: (10 * scale).clamp(6, 18)),
        Text(
          'EMSafe S1 is now synced with your secure session. Real-time monitoring active.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: (18 * scale).clamp(14, 22),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context, {required double scale}) {
    return SizedBox(
      width: double.infinity,
      height: (56 * scale).clamp(46, 74),
      child: ElevatedButton(
        onPressed: () {
          // `context` viene del build de PairYourSensorScreen.
          // Se mantiene aquí para el routing desde el popup.
          Navigator.of(context).pushNamed(AppRoutes.onboardingFinalStep);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB2C5FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12 * scale),
          ),
        ),
        child: Text(
          'Next',
          style: TextStyle(
            fontSize: (16 * scale).clamp(14, 20),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF002B73),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryRow({required double scale}) {
    return SizedBox(
      width: double.infinity,
      height: (40 * scale).clamp(34, 70),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        alignment: Alignment.center,
        child: Text(
          'Configure Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: (16 * scale).clamp(14, 20),
          ),
        ),
      ),
    );
  }
}

class _HeaderLeft extends StatelessWidget {
  final double scale;

  const _HeaderLeft({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: (24 * scale).clamp(18, 40),
          height: (24 * scale).clamp(18, 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12 * scale),
            color: Colors.transparent,
          ),
          child: Center(
            child: Icon(
              Icons.bluetooth_audio,
              size: (16 * scale).clamp(12, 26),
              color: AppTheme.primaryBlue,
            ),
          ),
        ),
        SizedBox(width: (8 * scale).clamp(6, 14)),
        Text(
          'EmSafe',
          style: TextStyle(
            color: const Color(0xFFB2C5FF),
            fontSize: (24 * scale).clamp(18, 34),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6 * scale,
          ),
        ),
      ],
    );
  }
}

class _HeaderRightClose extends StatelessWidget {
  final double scale;

  const _HeaderRightClose(this.scale);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (24 * scale).clamp(18, 40),
      height: (24 * scale).clamp(18, 40),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.close,
          size: (16 * scale).clamp(12, 22),
          color: const Color(0xFFC2C6D8),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

