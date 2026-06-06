import 'dart:ui';

import 'package:flutter/material.dart';

/// Reset Password (Etapa 2)
/// Implementación responsive + glass/blur basada en el CSS provisto.
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    // Artboard del CSS: 426 x 884
    final double artW = 426 * scale;
    final double artH = 884 * scale;

    // Background blur overlays
    final double blurW = 156 * scale;
    final double blurH = 353.59 * scale;
    final double blurRadius = 12 * scale;

    final double headerH = 65 * scale;
    final double mainTopPad = 195 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Center(
        child: SizedBox(
          width: artW,
          height: artH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Visual Polish backgrounds
              Positioned(
                right: -19.5 * scale,
                top: -88.39 * scale,
                width: blurW,
                height: blurH,
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(blurRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 60 * scale, sigmaY: 60 * scale),
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
                left: -19.5 * scale,
                bottom: -88.39 * scale,
                width: blurW,
                height: blurH,
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(blurRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 60 * scale, sigmaY: 60 * scale),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(101, 218, 255, 0.05),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Header
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: headerH,
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
                          children: [
                            // left icon pill (placeholder)
                            Container(
                              width: 24 * scale,
                              height: 24 * scale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12 * scale),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 16 * scale,
                                color: const Color(0xFFB2C5FF),
                              ),
                            ),
                            SizedBox(width: 8 * scale),
                            Text(
                              'EmSafe',
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                                fontSize: 24 * scale,
                                height: 32 / (24 * scale),
                                letterSpacing: -0.6 * scale,
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

              // Main content
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  child: Column(
                    children: [
                      SizedBox(height: mainTopPad),
                      // Card container (394x469 approx from CSS)
                      SizedBox(
                        width: 394 * scale,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 104 * scale,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 0),
                                    Text(
                                      'Reset Password',
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
                                      'Enter your email and we’ll send a reset link.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16 * scale,
                                        height: 24 / (16 * scale),
                                        color: const Color(0xFFC2C6D8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 32 * scale),

                            // Glass panel (overlay+border+blur)
                            Container(
                              width: 394 * scale,
                              height: 277 * scale,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(22, 27, 34, 0.7),
                                borderRadius: BorderRadius.circular(8 * scale),
                                border: Border.all(
                                  color: const Color.fromRGBO(66, 70, 85, 0.3),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8 * scale),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                                              blurRadius: 25 * scale,
                                              offset: const Offset(0, 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(32 * scale),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Form block
                                          SizedBox(
                                            width: 328 * scale,
                                            height: 195 * scale,
                                            child: Column(
                                              children: [
                                                // Label
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Registered Email Address',
                                                    style: TextStyle(
                                                      fontFamily: 'JetBrains Mono',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12 * scale,
                                                      height: 16 / (12 * scale),
                                                      letterSpacing: 1.2 * scale,
                                                      color: const Color(0xFFC2C6D8),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20 * scale),
                                                // Input
                                                Container(
                                                  height: 57 * scale,
                                                  width: 328 * scale,
                                                  padding: EdgeInsets.only(left: 48 * scale, right: 16 * scale),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF0B0E16),
                                                    borderRadius: BorderRadius.circular(4 * scale),
                                                    border: Border.all(
                                                      color: const Color.fromRGBO(66, 70, 85, 0.5),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 16 * scale,
                                                        top: 0,
                                                        bottom: 0,
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            width: 20 * scale,
                                                            height: 16 * scale,
                                                            color: const Color(0xFF8C90A1),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          'name@medical-node.com',
                                                          style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 16 * scale,
                                                            height: 19 / (16 * scale),
                                                            color: const Color.fromRGBO(140, 144, 161, 0.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // helper tiny row (icon+text) placeholder
                                                SizedBox(height: 8 * scale),
                                                Container(
                                                  width: 328 * scale,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 16 * scale,
                                                        height: 11.67 * scale,
                                                        color: const Color(0xFF8C90A1),
                                                      ),
                                                      SizedBox(width: 4 * scale),
                                                      Expanded(
                                                        child: Text(
                                                          'We’ll send a reset link to your inbox.',
                                                          style: TextStyle(
                                                            fontFamily: 'JetBrains Mono',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 11 * scale,
                                                            height: 16 / (11 * scale),
                                                            color: const Color(0xFF8C90A1),
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                // Button
                                                Container(
                                                  width: 328 * scale,
                                                  height: 56 * scale,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF5B8CFF),
                                                    borderRadius: BorderRadius.circular(4 * scale),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color.fromRGBO(91, 140, 255, 0.1),
                                                        blurRadius: 10 * scale,
                                                        offset: const Offset(0, 10),
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pushNamed('/etapa2/verification-success');
                                                    },
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(4 * scale),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Send',
                                                      style: TextStyle(
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16 * scale,
                                                        height: 24 / (16 * scale),
                                                        color: const Color(0xFF002565),
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
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

