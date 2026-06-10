import 'dart:ui';

import 'package:flutter/material.dart';

/// Verification Success (Etapa 2)
/// Scroll-safe + responsive (evita overflows en móviles).
class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double artW = 426 * scale;
    final double artH = 1160 * scale;

    final double headerH = 64 * scale;
    final double mainTopPad = 64 * scale;

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
                      // Background decoration overlays
                      Positioned(
                        top: -116 * scale,
                        right: -39 * scale,
                        width: 500 * scale,
                        height: 500 * scale,
                        child: Opacity(
                          opacity: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 60 * scale,
                                sigmaY: 60 * scale,
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(178, 197, 255, 0.05),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -116 * scale,
                        left: -39 * scale,
                        width: 500 * scale,
                        height: 500 * scale,
                        child: Opacity(
                          opacity: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 60 * scale,
                                sigmaY: 60 * scale,
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(101, 218, 255, 0.05),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Header TopAppBar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: headerH,
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(16, 19, 27, 0.8),
                              border: const Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(66, 70, 85, 0.3),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 6 * scale,
                                        sigmaY: 6 * scale,
                                      ),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24 * scale),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Container(
                                        width: 20 * scale,
                                        height: 16 * scale,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFB2C5FF),
                                          borderRadius:
                                              BorderRadius.circular(4 * scale),
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

                      // Main
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(top: mainTopPad),
                          child: Stack(
                            children: [
                              // Central visual container (approx)
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 394 * scale,
                                  height: 522 * scale,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: 258 * scale,
                                        left: 19.19 * scale,
                                        right: 19.19 * scale,
                                        child: Text(
                                          'Verification Success',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 40 * scale,
                                            height: 48 / 40,
                                            letterSpacing: -0.8 * scale,
                                            color: const Color(0xFFE1E2EE),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 322 * scale,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 2.31 * scale),
                                          child: Text(
                                            "You’re all set. Going to dashboard…",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18 * scale,
                                              height: 28 / 18,
                                              color: const Color(0xFFC2C6D8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 426 * scale,
                                        left: 0,
                                        right: 0,
                                        child: SizedBox(
                                          height: 64 * scale,
                                          width: 394 * scale,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF00C0E9),
                                              borderRadius:
                                                  BorderRadius.circular(8 * scale),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  '/etapa2/going-to-dashboard',
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8 * scale),
                                                ),
                                              ),
                                              child: Text(
                                                'Continue',
                                                style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24 * scale,
                                                  height: 32 / 24,
                                                  color: const Color(0xFF004A5B),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: (426 * scale) + 64 * scale,
                                        left: 0,
                                        right: 0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 8 * scale,
                                              height: 8 * scale,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF65DAFF),
                                                borderRadius:
                                                    BorderRadius.circular(12 * scale),
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
                                        ),
                                      ),

                                      // Success badge & icon (approx)
                                      Positioned(
                                        top: 0,
                                        left: 66 * scale,
                                        child: SizedBox(
                                          width: 226 * scale,
                                          height: 226 * scale,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(32 * scale),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 10 * scale,
                                                    sigmaY: 10 * scale,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(22, 27, 34, 0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(32 * scale),
                                                      border: Border.all(
                                                        color: const Color(0xFF21262D),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(48 * scale),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(width: double.infinity),
                                                          Container(
                                                            width: 66.67 * scale,
                                                            height: 66.67 * scale,
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFF65DAFF),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                12 * scale,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: -15 * scale,
                                                top: -15 * scale,
                                                child: Container(
                                                  width: 29.33 * scale,
                                                  height: 32.67 * scale,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF00C0E9),
                                                    borderRadius:
                                                        BorderRadius.circular(12 * scale),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Bento-lite cards
                                      Positioned(
                                        top: 122 * scale,
                                        left: 24 * scale,
                                        right: 24 * scale,
                                        child: _BentoLite(scale: scale),
                                      ),
                                      Positioned(
                                        top: 244 * scale,
                                        left: 24 * scale,
                                        right: 24 * scale,
                                        child: _BentoLite2(scale: scale),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Bottom separation
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 426 * scale,
                                  height: 80 * scale,
                                  color: Colors.transparent,
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

class _BentoLite extends StatelessWidget {
  const _BentoLite({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
        child: Container(
          height: 106 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.7),
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROTOCOL',
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * scale,
                    height: 16 / 12,
                    letterSpacing: 1.2 * scale,
                    color: const Color(0xFF8C90A1),
                  ),
                ),
                SizedBox(height: 8 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Session ID',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.w500,
                        fontSize: 12 * scale,
                        height: 16 / 12,
                        letterSpacing: 1.2 * scale,
                        color: const Color(0xFF8C90A1),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16 * scale,
                          height: 21 * scale,
                          color: const Color(0xFF65DAFF),
                        ),
                        SizedBox(width: 4 * scale),
                        Text(
                          'B2C5',
                          style: TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontWeight: FontWeight.w500,
                            fontSize: 24 * scale,
                            height: 32 / 24,
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
  const _BentoLite2({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
        child: Container(
          height: 106 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.7),
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STATUS',
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * scale,
                    height: 16 / 12,
                    letterSpacing: 1.2 * scale,
                    color: const Color(0xFF8C90A1),
                  ),
                ),
                SizedBox(height: 8 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.w500,
                        fontSize: 24 * scale,
                        height: 32 / 24,
                        color: const Color(0xFFB2C5FF),
                      ),
                    ),
                    Container(
                      width: 16 * scale,
                      height: 21 * scale,
                      color: const Color(0xFF65DAFF),
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

