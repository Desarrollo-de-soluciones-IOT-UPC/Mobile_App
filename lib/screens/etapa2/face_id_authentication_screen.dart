import 'dart:ui';

import 'package:flutter/material.dart';

/// Face ID Authentication (Etapa 2)
/// Refactor responsive: sin artboard rígido/altura fija.
class FaceIdAuthenticationScreen extends StatelessWidget {
  const FaceIdAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (48 * scale),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * scale,
                      vertical: 24 * scale,
                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 32 * scale,
                                      height: 32 * scale,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12 * scale),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 16 * scale,
                                        color: const Color(0xFFC2C5FF),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12 * scale,
                                        vertical: 6 * scale,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF272A33),
                                        borderRadius:
                                            BorderRadius.circular(4 * scale),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              66, 70, 85, 0.2),
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
                                          color: const Color(0xFFC2C6D8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16 * scale),

                                // Title/subtitle
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Face ID Authentication',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28 * scale,
                                          height: 1.1,
                                          letterSpacing: -0.6 * scale,
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
                                          fontSize: 16 * scale,
                                          height: 1.5,
                                          color: const Color(0xFFC2C6D8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20 * scale),

                                // Scanner graphic
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12 * scale),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF161B24),
                                          borderRadius:
                                              BorderRadius.circular(12 * scale),
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                66, 70, 85, 0.3),
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16 * scale),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 220 * scale / (0.85 * scale + 0.15),
                                                    height: 220 * scale / (0.85 * scale + 0.15),
                                                    decoration: BoxDecoration(
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xFFFFFFFF),
                                                          Color(0xFFECF0FF)
                                                        ],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12 * scale),
                                                    ),
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 96 * scale,
                                                      color:
                                                          const Color(0xFFB2C5FF)
                                                              .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  top: 90 * scale / (0.85 * scale + 0.15),
                                                  child: Container(
                                                    height: 6 * scale,
                                                    decoration: BoxDecoration(
                                                      gradient: const LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [
                                                          Color.fromRGBO(
                                                              101, 218, 255, 0),
                                                          Color(0xFF65DAFF),
                                                          Color.fromRGBO(
                                                              101, 218, 255, 0),
                                                        ],
                                                        stops: [0.0, 0.5, 1.0],
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              const Color(0xFF65DAFF),
                                                          blurRadius: 20 * scale,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  bottom: -8 * scale,
                                                  child: Center(
                                                    child: Container(
                                                      width: 48 * scale,
                                                      height: 48 * scale,
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFF00C0E9),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12 * scale),
                                                        border: Border.all(
                                                          color: Colors.white
                                                              .withOpacity(0.2),
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                0, 192, 233, 0.5),
                                                            blurRadius: 15 * scale,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Container(
                                                          width: 16.3 * scale,
                                                          height: 12.02 * scale,
                                                          color: const Color(0xFF004A5B),
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
                                  ),
                                ),

                                SizedBox(height: 16 * scale),

                                // Readouts
                                Row(
                                  children: [
                                    Expanded(
                                      child: _ReadoutBox(
                                        scale: scale,
                                        color: const Color(0xFF65DAFF),
                                        value: 'Register',
                                      ),
                                    ),
                                    SizedBox(width: 12 * scale),
                                    Expanded(
                                      child: _ReadoutBox(
                                        scale: scale,
                                        color: const Color(0xFFB2C5FF),
                                        value: 'OK',
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 18 * scale),

                                SizedBox(
                                  width: double.infinity,
                                  height: 56 * scale,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          '/etapa2/verify-identity');
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFB2C5FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12 * scale),
                                      ),
                                    ),
                                    child: Text(
                                      'Register Face',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16 * scale,
                                        color: const Color(0xFF002B73),
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
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ReadoutBox extends StatelessWidget {
  const _ReadoutBox({
    required this.scale,
    required this.color,
    required this.value,
  });

  final double scale;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.6),
            borderRadius: BorderRadius.circular(10 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROTOCOL',
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontWeight: FontWeight.w500,
                  fontSize: 11 * scale,
                  color: const Color(0xFFC2C6D8),
                  height: 1.3,
                  letterSpacing: 1.1 * scale,
                ),
              ),
              SizedBox(height: 6 * scale),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontWeight: FontWeight.w600,
                  fontSize: 20 * scale,
                  color: color,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

