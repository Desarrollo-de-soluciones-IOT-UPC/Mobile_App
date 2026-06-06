import 'dart:ui';

import 'package:flutter/material.dart';

/// Verify Identity (Etapa 2)
/// Full UI/UX en Flutter + responsive + glass (sin usar SVG como imagen).
class VerifyIdentityScreen extends StatelessWidget {
  const VerifyIdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double artW = 426 * scale;
    final double artH = 884 * scale;

    final double headerH = 65 * scale;
    final double mainPaddingTop = 92.25 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Center(
        child: SizedBox(
          width: artW,
          height: artH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background Decorative Element: Encrypted Data Pattern (approx)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color.fromRGBO(178, 197, 255, 0.05),
                      ],
                    ),
                  ),
                  child: null,
                ),
              ),

              // Header Navigation
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: headerH,
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(16, 19, 27, 0.8),
                            border: Border(
                              bottom: BorderSide(
                                color: const Color.fromRGBO(66, 70, 85, 0.3),
                                width: 1,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12 * scale, sigmaY: 12 * scale),
                            child: const SizedBox.expand(),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                          child: Row(
                            children: [
                              // Back button shell (visual only)
                              Container(
                                width: 32 * scale,
                                height: 32 * scale,
                                padding: EdgeInsets.all(8 * scale),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * scale),
                                ),
                                child: Container(
                                  width: 16 * scale,
                                  height: 16 * scale,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB2C5FF),
                                    borderRadius: BorderRadius.circular(3 * scale),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16 * scale),
                              Text(
                                'EmSafe',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24 * scale,
                                  height: 32 / 24,
                                  letterSpacing: -0.6 * scale,
                                  color: const Color(0xFFB2C5FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main layout
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: mainPaddingTop),
                  child: Column(
                    children: [
                      SizedBox(height: 0),
                      // Central OTP Card + content
                      Expanded(
                        child: Stack(
                          children: [
                            // Container holding OTP card
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 394 * scale,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _CentralOtpCard(scale: scale, context: context),
                                    SizedBox(height: 16 * scale),
                                  ],
                                ),
                              ),
                            ),

                            // Verification Success Overlay Placeholder
                            Positioned(
                              right: 0,
                              bottom: 0,
                              width: 256 * scale,
                              height: 256 * scale,
                              child: Opacity(
                                opacity: 0.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12 * scale),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 32 * scale, sigmaY: 32 * scale),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFB2C5FF),
                                            Color(0xFF65DAFF),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _CentralOtpCard extends StatelessWidget {
  const _CentralOtpCard({required this.scale, required this.context});

  final double scale;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: Stack(
        children: [
          // Card background with glass
          Container(
            width: 394 * scale,
            height: 537 * scale,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(22, 27, 34, 0.7),
              borderRadius: BorderRadius.circular(8 * scale),
              border: Border.all(
                color: const Color.fromRGBO(66, 70, 85, 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20 * scale,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
              child: const SizedBox.expand(),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(32 * scale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 0),
                SizedBox(
                  width: 328 * scale,
                  height: 180 * scale,
                  child: Column(
                    children: [
                      // Status Header
                      SizedBox(height: 0),
                      _StatusHeader(scale: scale),
                    ],
                  ),
                ),

                SizedBox(height: 16 * scale),

                // OTP Inputs + action button
                SizedBox(
                  width: 328 * scale,
                  child: Column(
                    children: [
                      _OtpArea(scale: scale),
                      SizedBox(height: 8 * scale),
                      _VerifyButton(scale: scale, onPressed: () {
                        Navigator.of(this.context).pushNamed('/etapa2/verification-success');
                      }),
                      SizedBox(height: 0),
                      // Footer Info + Bento style grid
                      _FooterInfo(scale: scale),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Contextual Security Info Grid (Bento Style) - overlay on top-right
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: 205 * scale,
              height: 82.5 * scale,
              child: _BentoGrid(scale: scale, isLeft: false),
            ),
          ),

          // Left Bento (overlay icon + label)
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 205 * scale,
              height: 82.5 * scale,
              child: _BentoGrid(scale: scale, isLeft: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _OverlayBorderIcon(scale: scale),
        SizedBox(height: 16 * scale),
        Text(
          'Verification',
          style: TextStyle(
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 32 * scale,
            height: 40 / 32,
            letterSpacing: -0.32 * scale,
            color: const Color(0xFFE1E2EE),
          ),
        ),
        SizedBox(height: 8 * scale),
        Text(
          'Enter the one-time code sent to you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16 * scale,
            height: 24 / 16,
            color: const Color(0xFFC2C6D8),
          ),
        ),
      ],
    );
  }
}

class _OverlayBorderIcon extends StatelessWidget {
  const _OverlayBorderIcon({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64 * scale,
      height: 64 * scale,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(91, 140, 255, 0.2),
        border: Border.all(
          color: const Color.fromRGBO(178, 197, 255, 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Center(
        child: Container(
          width: 24 * scale,
          height: 30 * scale,
          decoration: const BoxDecoration(color: Color(0xFFB2C5FF)),
        ),
      ),
    );
  }
}

class _OtpArea extends StatelessWidget {
  const _OtpArea({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16 * scale),
        SizedBox(
          width: 328 * scale,
          height: 130 * scale,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  final bool active = i == 1;
                  return _OtpBox(
                    scale: scale,
                    isActive: active,
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.scale, required this.isActive});

  final double scale;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.67 * scale,
      height: 54.67 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E16),
        borderRadius: BorderRadius.circular(4 * scale),
        border: Border.all(
          color: isActive ? const Color(0xFF2563EB) : const Color.fromRGBO(66, 70, 85, 0.4),
          width: 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF2563EB),
                  blurRadius: 0,
                  spreadRadius: 1,
                ),
              ]
            : const [],
      ),
      child: Center(
        child: Text(
          '',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontWeight: FontWeight.w500,
            fontSize: 24 * scale,
            height: 32 / 24,
            color: const Color(0xFFB2C5FF),
          ),
        ),
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton({required this.scale, required this.onPressed});
  final double scale;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56 * scale,
      width: 328 * scale,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF5B8CFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12 * scale),
          ),
        ),
        child: Text(
          'Verify',
          style: TextStyle(
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 16 * scale,
            height: 24 / 16,
            color: const Color(0xFF002565),
          ),
        ),
      ),
    );
  }
}

class _FooterInfo extends StatelessWidget {
  const _FooterInfo({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16 * scale),
      child: SizedBox(
        width: 328 * scale,
        height: 97 * scale,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0),
            Container(
              width: 215.28 * scale,
              height: 24 * scale,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 11.67 * scale,
                    height: 11.67 * scale,
                    decoration: const BoxDecoration(color: Color(0xFFC2C6D8)),
                  ),
                  SizedBox(width: 4 * scale),
                  Text(
                    'Security code',
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 16 * scale,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFC2C6D8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8 * scale),
            Container(
              width: 102.03 * scale,
              height: 24 * scale,
              alignment: Alignment.center,
              child: Text(
                'Resend in 00:30',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * scale,
                  height: 24 / 16,
                  color: const Color(0xFFB2C5FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BentoGrid extends StatelessWidget {
  const _BentoGrid({required this.scale, required this.isLeft});

  final double scale;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.7),
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Container(
                  width: 16 * scale,
                  height: 20 * scale,
                  color: isLeft ? const Color(0xFFB2C5FF) : const Color(0xFF65DAFF),
                ),
                SizedBox(width: 8 * scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLeft ? 'Encrypted' : 'Verified',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 11 * scale,
                        height: 16 / 11,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.55 * scale,
                        color: const Color(0xFFE1E2EE),
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    SizedBox(height: 16 * scale / 2),
                    Text(
                      isLeft ? 'End-to-end secured' : 'Time-limited session',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12 * scale,
                        height: 16 / 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFC2C6D8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

