import 'dart:ui';

import 'package:flutter/material.dart';

/// Face ID Authentication (Etapa 2)
/// Responsive + glass/blur, con un contenedor de "foto" (placeholder) tipo referencia.
class FaceIdAuthenticationScreen extends StatelessWidget {
  const FaceIdAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double artW = 426 * scale;
    final double artH = 884 * scale;

    // Background blur elements
    final double blur1W = 500 * scale;
    final double blur1H = 500 * scale;
    final double blur2W = 400 * scale;
    final double blur2H = 400 * scale;

    final double blurRadius = 12 * scale;

    // Outer container height (central biometric container)
    final double centralH = 708 * scale;
    final double outerPadTop = 64 * scale;

    final double scannerLeft = 51 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Center(
        child: SizedBox(
          width: artW,
          height: artH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background overlay blur
              Positioned(
                left: 97.5 * scale,
                top: 221 * scale,
                width: blur1W,
                height: blur1H,
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(blurRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 60 * scale, sigmaY: 60 * scale),
                      child: Container(
                        color: const Color.fromRGBO(178, 197, 255, 0.1),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 97.5 * scale,
                bottom: 221 * scale,
                width: blur2W,
                height: blur2H,
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(blurRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50 * scale, sigmaY: 50 * scale),
                      child: Container(
                        color: const Color.fromRGBO(101, 218, 255, 0.1),
                      ),
                    ),
                  ),
                ),
              ),

              // Central content
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: outerPadTop),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // Title section
                            Positioned(
                              left: 43.88 * scale,
                              right: 43.88 * scale,
                              top: 0,
                              height: 116 * scale,
                              child: Column(
                                children: [
                                  SizedBox(height: 0),
                                  Text(
                                    'Face ID Authentication',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 40 * scale,
                                      height: 48 / (40 * scale),
                                      letterSpacing: -0.8 * scale,
                                      color: const Color(0xFFE1E2EE),
                                    ),
                                  ),
                                  SizedBox(height: 8 * scale),
                                  Text(
                                    'Scan your face to register the profile.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18 * scale,
                                      height: 28 / (18 * scale),
                                      color: const Color(0xFFC2C6D8),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Scanner graphic
                            Positioned(
                              left: scannerLeft,
                              right: scannerLeft,
                              top: 116 * scale,
                              height: 336 * scale,
                              child: _ScannerCard(scale: scale),
                            ),

                            // Data readout overlay (two boxes)
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 452 * scale,
                              child: SizedBox(
                                height: 86 * scale,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _ReadoutBox(
                                        scale: scale,
                                        leftSide: true,
                                        valueTop: 'PROTOCOL',
                                        valueBottom: 'STATUS',
                                        valueMainTop: 'Register',
                                      ),
                                    ),
                                    SizedBox(width: 0),
                                    Expanded(
                                      child: _ReadoutBox(
                                        scale: scale,
                                        leftSide: false,
                                        valueTop: 'PROTOCOL',
                                        valueBottom: 'STATUS',
                                        valueMainTop: 'OK',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Footer action
                            Positioned(
                              left: 16 * scale,
                              right: 16 * scale,
                              top: 586 * scale,
                              height: 56 * scale,
                              child: SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/etapa2/verify-identity');
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFB2C5FF),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12 * scale),
                                    ),
                                  ),
                                  child: Text(
                                    'Register Face',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16 * scale,
                                      color: const Color(0xFF002B73),
                                      height: 24 / (16 * scale),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Success indicator overlay (center bottom of scanner)
                            Positioned(
                              left: (artW / 2) - (48 * scale) / 2,
                              bottom: -16 * scale,
                              child: _SuccessIndicator(scale: scale),
                            ),

                            // Data points / additional tiny elements are omitted for practicality.
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Backdrop blur header (top bar look)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 65 * scale,
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
                            filter: ImageFilter.blur(sigmaX: 12 * scale, sigmaY: 12 * scale),
                            child: const SizedBox.expand(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 32 * scale,
                              height: 32 * scale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12 * scale),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16 * scale,
                                color: const Color(0xFFC2C5FF),
                              ),
                            ),
                            Container(
                              width: 118.8 * scale,
                              padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                              decoration: BoxDecoration(
                                color: const Color(0xFF272A33),
                                borderRadius: BorderRadius.circular(4 * scale),
                                border: Border.all(
                                  color: const Color.fromRGBO(66, 70, 85, 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Secure',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'JetBrains Mono',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12 * scale,
                                  height: 16 / (12 * scale),
                                  color: const Color(0xFFC2C6D8),
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

class _ScannerCard extends StatelessWidget {
  const _ScannerCard({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Outer ring
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(66, 70, 85, 0.3),
                width: 2 * scale,
              ),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
          ),
        ),

        // Inner border
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(101, 218, 255, 0.2),
                  width: 1 * scale,
                ),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
            ),
          ),
        ),

        // Biometric target "photo" placeholder
        Positioned(
          left: 32 * scale,
          right: 32 * scale,
          top: 32 * scale,
          bottom: 32 * scale,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12 * scale),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(22, 27, 34, 0.6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 50 * scale,
                      offset: const Offset(0, 25),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // pseudo photo
                    Center(
                      child: Container(
                        width: 224 * scale / 1.0,
                        height: 224 * scale / 1.0,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFFFFF), Color(0xFFECF0FF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 96 * scale,
                          color: const Color(0xFFB2C5FF).withOpacity(0.6),
                        ),
                      ),
                    ),

                    // scanning laser
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 44.8 * scale,
                      height: 100 * scale,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromRGBO(101, 218, 255, 0), Color(0xFF65DAFF), Color.fromRGBO(101, 218, 255, 0)],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 220 * scale,
                            height: 6 * scale,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF65DAFF),
                                  blurRadius: 20 * scale,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessIndicator extends StatelessWidget {
  const _SuccessIndicator({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 48 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF00C0E9),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 2 * scale),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 192, 233, 0.5),
            blurRadius: 15 * scale,
          )
        ],
      ),
      child: Center(
        child: Container(
          width: 16.3 * scale,
          height: 12.02 * scale,
          color: const Color(0xFF004A5B),
        ),
      ),
    );
  }
}

class _ReadoutBox extends StatelessWidget {
  const _ReadoutBox({
    required this.scale,
    required this.leftSide,
    required this.valueTop,
    required this.valueBottom,
    required this.valueMainTop,
  });

  final double scale;
  final bool leftSide;
  final String valueTop;
  final String valueBottom;
  final String valueMainTop;

  @override
  Widget build(BuildContext context) {
    // CSS uses two overlaid blur boxes; here we approximate with a single glass pill.
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(22, 27, 34, 0.6),
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(
          color: const Color.fromRGBO(66, 70, 85, 0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8 * scale),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
          child: Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              children: [
                Text(
                  leftSide ? '67.2px' : '67.2px',
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * scale,
                    height: 16 / (12 * scale),
                    letterSpacing: 1.2 * scale,
                    color: const Color(0xFFC2C6D8),
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  valueMainTop,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.w500,
                    fontSize: 24 * scale,
                    height: 32 / (24 * scale),
                    color: leftSide ? const Color(0xFF65DAFF) : const Color(0xFFB2C5FF),
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

