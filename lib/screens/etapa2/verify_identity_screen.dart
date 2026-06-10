import 'dart:ui';

import 'package:flutter/material.dart';

/// Verify Identity (Etapa 2)
/// Refactor responsive estricto:
/// - Scroll obligatorio (SingleChildScrollView + ConstrainedBox)
/// - OTP row en Row con Flexible para que no desborde horizontal (<360px)
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: SizedBox(
                  width: artW,
                  height: artH,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Header
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        height: headerH,
                        child: IgnorePointer(
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
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 12 * scale,
                                        sigmaY: 12 * scale,
                                      ),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16 * scale),
                                    child: Row(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Main
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(top: mainPaddingTop),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 394 * scale,
                                        child: _OtpCard(scale: scale, context: context),
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
            ),
          );
        },
      ),
    );
  }
}

class _OtpCard extends StatelessWidget {
  const _OtpCard({required this.scale, required this.context});

  final double scale;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: Stack(
        children: [
          Container(
            width: 394 * scale,
            // Sin Column rígido: altura gestionada por contención interna.
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
          Padding(
            padding: EdgeInsets.all(32 * scale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusHeader(scale: scale),
                SizedBox(height: 16 * scale),

                // OTP area
                _OtpArea(scale: scale),

                SizedBox(height: 8 * scale),

                SizedBox(
                  height: 56 * scale,
                  width: 328 * scale,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(this.context)
                          .pushNamed('/etapa2/verification-success');
                    },
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
                ),

                SizedBox(height: 16 * scale),
                _FooterInfo(scale: scale),
              ],
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
        Container(
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
        ),
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

class _OtpArea extends StatelessWidget {
  const _OtpArea({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328 * scale,
      child: Column(
        children: [
          SizedBox(height: 16 * scale),
          // Regla: OTP row sin overflow horizontal
          LayoutBuilder(
            builder: (context, constraints) {
              final double boxSize = (constraints.maxWidth - (5 * 6 * scale)) / 6;
              final double s = boxSize.clamp(24 * scale, 56 * scale);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  final bool active = i == 1;
                  return SizedBox(
                    width: s,
                    height: s,
                    child: _OtpBox(active: active, scale: scale),
                  );
                }),
              );
            },
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

class _FooterInfo extends StatelessWidget {
  const _FooterInfo({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
    );
  }
}

