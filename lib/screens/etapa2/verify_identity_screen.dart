import 'dart:ui';

import 'package:flutter/material.dart';

/// Verify Identity (Etapa 2)
/// Responsive + compacto y sin alturas rígidas.
class VerifyIdentityScreen extends StatelessWidget {
  const VerifyIdentityScreen({super.key});

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
                                  // Header (visual)
                                  Row(
                                    children: [
                                      Container(
                                        width: 32 * scale,
                                        height: 32 * scale,
                                        padding: EdgeInsets.all(8 * scale),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12 * scale),
                                        ),
                                        child: Container(
                                          width: 16 * scale,
                                          height: 16 * scale,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFB2C5FF),
                                            borderRadius:
                                                BorderRadius.circular(3 * scale),
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
                                  SizedBox(height: 24 * scale),

                                  // Title block
                                  Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 64 * scale,
                                          height: 64 * scale,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                91, 140, 255, 0.2),
                                            border: Border.all(
                                              color: const Color.fromRGBO(
                                                  178, 197, 255, 0.3),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    12 * scale),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 24 * scale,
                                              height: 30 * scale,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFB2C5FF),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16 * scale),
                                        Text(
                                          'Verification',
                                          textAlign: TextAlign.center,
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
                                    ),
                                  ),

                                  SizedBox(height: 20 * scale),

                                  // OTP boxes
                                  Center(
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final maxW = constraints.maxWidth;
                                        final double boxW =
                                            (maxW - (5 * 8 * scale)) / 6;
                                        final double s = boxW.clamp(
                                          24 * scale,
                                          56 * scale,
                                        );
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(6, (i) {
                                            final bool active = i == 1;
                                            return SizedBox(
                                              width: s,
                                              height: s,
                                              child: _OtpBox(
                                                active: active,
                                                scale: scale,
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(height: 18 * scale),

                                  // Verify button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56 * scale,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          '/etapa2/verification-success',
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0xFF5B8CFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  12 * scale),
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
                                  ),

                                  SizedBox(height: 16 * scale),
                                  Center(
                                    child: Column(
                                      children: [
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
                                        SizedBox(height: 8 * scale),
                                        Text(
                                          'Resend in 00:30',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16 * scale,
                                            height: 24 / 16,
                                            color: const Color(0xFFB2C5FF),
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

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.active, required this.scale});

  final bool active;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E16),
        borderRadius: BorderRadius.circular(4 * scale),
        border: Border.all(
          color: active
              ? const Color(0xFF2563EB)
              : const Color.fromRGBO(66, 70, 85, 0.4),
          width: 1,
        ),
        boxShadow: active
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

