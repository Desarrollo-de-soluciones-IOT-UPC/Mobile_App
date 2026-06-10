import 'dart:ui';

import 'package:flutter/material.dart';

/// Verification Success (Etapa 2)
/// Responsive sin artboard rígido.
class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 450 * scale,
                height: 450 * scale,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(178, 197, 255, 0.04),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24 * scale,
                    vertical: 24 * scale,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - (48 * scale),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16 * scale),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 420),
                            decoration: BoxDecoration(
                              color: const Color(0x0D161B22),
                              borderRadius: BorderRadius.circular(16 * scale),
                              border: Border.all(
                                color: const Color.fromRGBO(140, 144, 161, 0.15),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 40 * scale,
                                  offset: Offset(0, 20 * scale),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24 * scale),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 20 * scale,
                                        height: 16 * scale,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFB2C5FF),
                                          borderRadius:
                                              BorderRadius.circular(4 * scale),
                                        ),
                                      ),
                                      SizedBox(width: 12 * scale),
                                      Text(
                                        'EmSafe',
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24 * scale,
                                          height: 32 / 24,
                                          letterSpacing: -0.6 * scale,
                                          color: const Color(0xFFB2C5FF),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 28 * scale),

                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Verification Success',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28 * scale,
                                            height: 1.2,
                                            letterSpacing: -0.8 * scale,
                                            color: const Color(0xFFE1E2EE),
                                          ),
                                        ),
                                        SizedBox(height: 12 * scale),
                                        Text(
                                          "You’re all set. Going to dashboard…",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16 * scale,
                                            height: 1.5,
                                            color: const Color(0xFFC2C6D8),
                                          ),
                                        ),
                                        SizedBox(height: 24 * scale),

                                        SizedBox(
                                          width: double.infinity,
                                          height: 56 * scale,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF00C0E9),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * scale),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  '/etapa2/going-to-dashboard',
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8 * scale),
                                                ),
                                              ),
                                              child: Text(
                                                'Continue',
                                                style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20 * scale,
                                                  color: const Color(0xFF004A5B),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 16 * scale),

                                        const _VerifiedTag(),

                                        SizedBox(height: 20 * scale),

                                        const _BentoLite(
                                          label: 'PROTOCOL',
                                          valueKey: 'Session ID',
                                          valueMain: 'B2C5',
                                          color: Color(0xFF65DAFF),
                                        ),
                                        SizedBox(height: 12 * scale),
                                        const _BentoLite2(
                                          label: 'STATUS',
                                          valueMain: 'OK',
                                          accent: Color(0xFFB2C5FF),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifiedTag extends StatelessWidget {
  const _VerifiedTag();

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.sizeOf(context).width / 390)
        .clamp(0.85, 1.15);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8 * scale,
          height: 8 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFF65DAFF),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
        ),
        SizedBox(width: 8 * scale),
        Text(
          'Verified',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontWeight: FontWeight.w500,
            fontSize: 12 * scale,
            height: 16 / 12,
            color: const Color(0xFF8C90A1),
          ),
        ),
      ],
    );
  }
}

class _BentoLite extends StatelessWidget {
  const _BentoLite({
    required this.label,
    required this.valueKey,
    required this.valueMain,
    required this.color,
  });

  final String label;
  final String valueKey;
  final String valueMain;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.sizeOf(context).width / 390)
        .clamp(0.85, 1.15);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 112 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.7),
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * scale,
                    letterSpacing: 1.2 * scale,
                    color: const Color(0xFF8C90A1),
                  ),
                ),
                SizedBox(height: 8 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      valueKey,
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.w500,
                        fontSize: 12 * scale,
                        letterSpacing: 1.2 * scale,
                        color: const Color(0xFF8C90A1),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16 * scale,
                          height: 21 * scale,
                          color: color,
                        ),
                        SizedBox(width: 4 * scale),
                        Text(
                          valueMain,
                          style: TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontWeight: FontWeight.w500,
                            fontSize: 24 * scale,
                            color: const Color(0xFFB2C5FF),
                          ),
                        ),
                      ],
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

class _BentoLite2 extends StatelessWidget {
  const _BentoLite2({
    required this.label,
    required this.valueMain,
    required this.accent,
  });

  final String label;
  final String valueMain;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.sizeOf(context).width / 390)
        .clamp(0.85, 1.15);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 112 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.7),
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * scale,
                    letterSpacing: 1.2 * scale,
                    color: const Color(0xFF8C90A1),
                  ),
                ),
                SizedBox(height: 10 * scale),
                Text(
                  valueMain,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 26 * scale,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

