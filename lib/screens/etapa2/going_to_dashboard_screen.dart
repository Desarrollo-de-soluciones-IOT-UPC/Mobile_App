import 'dart:ui';

import 'package:flutter/material.dart';

/// Going to dashboard (Etapa 2)
/// Refactor responsive estricto:
/// - Scroll obligatorio (SingleChildScrollView + ConstrainedBox)
/// - Evita overflows en móviles (sin depender de Column rígidos).
class GoingToDashboardScreen extends StatelessWidget {
  const GoingToDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double artW = 426 * scale;
    final double artH = 884 * scale;

    final double headerH = 61 * scale;

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
                      // Background ambience
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF0D1117), Color(0xFF0D1117)],
                            ),
                          ),
                        ),
                      ),

                      // Glows
                      Positioned(
                        left: (artW / 2) - (600 * scale / 2),
                        top: (artH / 2) - (600 * scale / 2),
                        width: 600 * scale,
                        height: 600 * scale,
                        child: IgnorePointer(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 60 * scale,
                                sigmaY: 60 * scale,
                              ),
                              child: Container(
                                color: const Color.fromRGBO(101, 218, 255, 0.05),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: (artW / 2) - (300 * scale / 2),
                        top: (artH / 2) - (300 * scale / 2),
                        width: 300 * scale,
                        height: 300 * scale,
                        child: IgnorePointer(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 40 * scale,
                                sigmaY: 40 * scale,
                              ),
                              child: Container(
                                color: const Color.fromRGBO(178, 197, 255, 0.1),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Header
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        height: headerH,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(16, 19, 27, 0.8),
                            border: const Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(66, 70, 85, 0.2),
                                width: 1,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              )
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24 * scale),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 16 * scale,
                                          height: 20 * scale,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFB2C5FF),
                                            borderRadius: BorderRadius.circular(4 * scale),
                                          ),
                                        ),
                                        SizedBox(width: 12 * scale),
                                        Text(
                                          'EmSafe',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20 * scale,
                                            color: const Color(0xFFB2C5FF),
                                            letterSpacing: -0.5 * scale,
                                            height: 28 / 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 32.72 * scale, height: 24 * scale),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Main content area (approx positions)
                      Positioned(
                        left: 24 * scale,
                        right: 24 * scale,
                        top: 103 * scale,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 212.62 * scale,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(22, 27, 34, 0.4),
                                        borderRadius: BorderRadius.circular(12 * scale),
                                        border: Border.all(
                                          color: const Color.fromRGBO(140, 144, 161, 0.1),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16 * scale),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12 * scale),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12 * scale),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [
                                                        const Color.fromRGBO(0, 192, 233, 0.08),
                                                        const Color.fromRGBO(178, 197, 255, 0.05),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Opacity(
                                                    opacity: 0.85,
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.medical_services_outlined,
                                                        color: const Color(0xFF65DAFF),
                                                        size: 92 * scale,
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
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12 * scale),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10 * scale,
                                          sigmaY: 10 * scale,
                                        ),
                                        child: const SizedBox.expand(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Progress bar
                      Positioned(
                        left: 35 * scale,
                        right: 71 * scale,
                        top: 635 * scale,
                        height: 2 * scale,
                        child: Container(
                          height: 2 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFF32343E),
                            borderRadius: BorderRadius.circular(2 * scale),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF65DAFF),
                                blurRadius: 10 * scale,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        const Color.fromRGBO(101, 218, 255, 0),
                                        const Color.fromRGBO(101, 218, 255, 0.1),
                                        const Color.fromRGBO(101, 218, 255, 0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        left: 24 * scale,
                        right: 24 * scale,
                        top: 685 * scale,
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            'Redirecting…',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16 * scale,
                              height: 24 / 16,
                              color: const Color(0xFFC2C6D8),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: (artW / 2) - (328.81 * scale / 2),
                        top: (artH / 2) - (142 * scale / 2) + 122 * scale,
                        child: _StatusBox(scale: scale),
                      ),

                      Positioned(
                        left: 24 * scale,
                        right: 24 * scale,
                        top: 740 * scale,
                        child: _ProtoLine(scale: scale),
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

class _StatusBox extends StatelessWidget {
  const _StatusBox({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
        child: Container(
          width: 328.81 * scale,
          height: 38 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.4),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(101, 218, 255, 0.15),
                blurRadius: 20 * scale,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24 * scale),
            child: Row(
              children: [
                Container(
                  width: 8 * scale,
                  height: 8 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF65DAFF),
                    borderRadius: BorderRadius.circular(12 * scale),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF65DAFF),
                        blurRadius: 8 * scale,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16 * scale),
                Expanded(
                  child: Text(
                    'Authenticated',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      fontWeight: FontWeight.w500,
                      fontSize: 14 * scale,
                      height: 20 / 14,
                      letterSpacing: 1.4 * scale,
                      color: const Color(0xFF65DAFF),
                    ),
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

class _ProtoLine extends StatelessWidget {
  const _ProtoLine({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.9,
        child: Container(
          width: 328.81 * scale,
          height: 106 * scale,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 27, 34, 0.35),
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(
              color: const Color.fromRGBO(66, 70, 85, 0.2),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12 * scale),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
              child: Padding(
                padding: EdgeInsets.all(24 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(
                      'Session: pending',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.w500,
                        fontSize: 12 * scale,
                        height: 16 / 12,
                        letterSpacing: 1.2 * scale,
                        color: const Color(0xFFB2C5FF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

