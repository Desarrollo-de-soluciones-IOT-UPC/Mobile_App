import 'dart:ui';

import 'package:flutter/material.dart';

import '../../routes/etapa2_routes.dart';
import '../../theme/app_theme.dart';

/// POPUP sobre la pantalla de Pairing Sensors.
/// Mantiene el diseño escalado con el mismo `scale` que el resto de onboarding.
class PairYourSensorScreen extends StatelessWidget {
  const PairYourSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);
    final double overlayRadius = 8 * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dimmer + blur para que el contenido anterior se vea tipo "cristal".
          Positioned.fill(
            child: Container(
              color: const Color.fromRGBO(16, 19, 27, 0.55),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: const SizedBox.expand(),
              ),
            ),
          ),

          Center(
            child: Container(
              width: (358 * scale).clamp(280, 420),
              height: (664 * scale).clamp(520, 720),
              decoration: BoxDecoration(
                color: const Color(0xFF151821).withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(overlayRadius),
                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(overlayRadius),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all((28 * scale).clamp(18, 40)),
                      child: Column(
                        children: [
                          _buildTopHeader(scale: scale),
                          SizedBox(height: (18 * scale).clamp(10, 30)),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildIoTIcon(scale: scale),
                                  SizedBox(height: (16 * scale).clamp(10, 26)),
                                  _buildTitleAndCopy(scale: scale),
                                  SizedBox(height: (18 * scale).clamp(10, 26)),

                                  // Tarjeta faltante del diseño.
                                  _buildSensorStatusCard(scale: scale),

                                  SizedBox(height: (20 * scale).clamp(12, 28)),

                                  _buildPrimaryButton(context, scale: scale),
                                  SizedBox(height: (12 * scale).clamp(8, 16)),
                                  _buildSecondaryRow(scale: scale),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader({required double scale}) {
    // En el diseño móvil nativo no hay X de cerrar.
    return Row(
      children: [
        _HeaderLeft(scale: scale),
        const Spacer(),
        SizedBox(
          width: (24 * scale).clamp(18, 40),
          height: (24 * scale).clamp(18, 40),
        ),
      ],
    );
  }

  Widget _buildIoTIcon({required double scale}) {
    final double iconOuter = (128 * scale).clamp(96, 170);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: iconOuter,
          height: iconOuter,
          decoration: BoxDecoration(
            color: AppTheme.primaryCyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(
              color: AppTheme.primaryCyan.withValues(alpha: 0.28),
            ),
          ),
          child: Center(
            child: Container(
              width: (92 * scale).clamp(70, 140),
              height: (92 * scale).clamp(70, 140),
              decoration: BoxDecoration(
                color: const Color(0xFF32343E),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.18),
                    blurRadius: (20 * scale).clamp(10, 40),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: (54 * scale).clamp(38, 72),
                  height: (54 * scale).clamp(38, 72),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  child: Icon(
                    Icons.bluetooth,
                    size: (28 * scale).clamp(22, 40),
                    color: const Color(0xFF0B0E16),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Badge de éxito ✓ (esquina inferior derecha, cuadrado azul).
        Positioned(
          right: (-6 * scale).clamp(-14, -3),
          bottom: (-6 * scale).clamp(-14, -3),
          child: Container(
            width: (56 * scale).clamp(40, 86),
            height: (56 * scale).clamp(40, 86),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(
                width: (3.5 * scale).clamp(2, 7),
                color: const Color(0xFF10131B),
              ),
            ),
            child: Center(
              child: Container(
                width: (26 * scale).clamp(18, 42),
                height: (26 * scale).clamp(18, 42),
                decoration: BoxDecoration(
                  color: const Color(0xFF002B73),
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Center(
                  child: Text(
                    '✓',
                    style: TextStyle(
                      fontSize: (18 * scale).clamp(14, 28),
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndCopy({required double scale}) {
    return Column(
      children: [
        Text(
          'Sensor\nConnected',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (40 * scale).clamp(26, 56),
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.02,
            letterSpacing: -0.4 * scale,
          ),
        ),
        SizedBox(height: (10 * scale).clamp(6, 18)),
        Text(
          'EMSafe S1 is now synced with your secure session. Real-time monitoring active.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: (18 * scale).clamp(14, 22),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSensorStatusCard({required double scale}) {
    final double radius = 16 * scale;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F1520).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AppTheme.cardBorder.withValues(alpha: 0.55),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: (24 * scale).clamp(12, 40),
          ),
        ],
      ),
      padding: EdgeInsets.all((16 * scale).clamp(12, 22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: (34 * scale).clamp(26, 54),
                height: (34 * scale).clamp(26, 54),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: (18 * scale).clamp(12, 30),
                  color: AppTheme.primaryCyan,
                ),
              ),
              SizedBox(width: (12 * scale).clamp(8, 14)),
              Expanded(
                child: Text(
                  'S1-X2400-ALPHA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (18 * scale).clamp(14, 22),
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: (12 * scale).clamp(8, 16)),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: (12 * scale).clamp(10, 18),
              horizontal: (12 * scale).clamp(10, 18),
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(
                color: AppTheme.primaryCyan.withValues(alpha: 0.28),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Signal',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: (14 * scale).clamp(12, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '98%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (20 * scale).clamp(16, 26),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: (8 * scale).clamp(6, 12)),
          Text(
            'Excellent connection quality',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: (13 * scale).clamp(11, 16),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, {required double scale}) {
    return SizedBox(
      width: double.infinity,
      height: (56 * scale).clamp(46, 74),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(Etapa2Routes.login, (route) => false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D76FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * scale),
          ),
        ),
        child: Text(
          'Finish Setup',
          style: TextStyle(
            fontSize: (16 * scale).clamp(14, 20),
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          color: Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          'Configure Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white60,
            fontSize: (16 * scale).clamp(14, 20),
            fontWeight: FontWeight.w600,
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
