import 'dart:ui';

import 'package:flutter/material.dart';

// Create Account (Etapa 2)
/// Responsive profesional (scroll obligatorio + tarjeta dinámica)
/// Mantiene el diseño compacto evitando alturas rígidas/artboards fijos.
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    // Referencia visual (artboard)
    final double artW = 426 * scale;
    final double artH = 1068 * scale;

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
                      // Ambient background
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 600 * scale,
                            height: 600 * scale,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(178, 197, 255, 0.1),
                              borderRadius: BorderRadius.circular(12 * scale),
                            ),
                          ),
                        ),
                      ),

                      // Main content
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * scale,
                            vertical: 63.5 * scale,
                          ),
                          child: _CreateAccountLayout(scale: scale),
                        ),
                      ),

                      // Header bar (visual)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: IgnorePointer(
                          child: Container(
                            height: 65 * scale,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(16, 19, 27, 0.8),
                              border: Border(
                                bottom: BorderSide(
                                  color: const Color.fromRGBO(66, 70, 85, 0.3),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32 * scale,
                                    height: 32 * scale,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12 * scale),
                                      color: Colors.transparent,
                                    ),
                                    child: Center(
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

class _CreateAccountLayout extends StatelessWidget {
  const _CreateAccountLayout({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    final double cardRadius = 8 * scale;
    final double cardW = 394 * scale;
    final double cardH = 877 * scale;
    final double formW = 344 * scale;

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: cardW,
        height: cardH,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x16161B22),
                      borderRadius: BorderRadius.circular(cardRadius),
                      border: Border.all(
                        color: const Color.fromRGBO(140, 144, 161, 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 50 * scale,
                          offset: Offset(0, 25 * scale),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardRadius),
                    color: Colors.white.withOpacity(0.002),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(24 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32 * scale,
                        height: 40 / 32,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.8 * scale,
                        color: const Color(0xFFB2C5FF),
                        fontFamily: 'Sora',
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                    Text(
                      'Begin your secure session and connect your monitoring hardware.',
                      style: TextStyle(
                        fontSize: 16 * scale,
                        height: 24 / 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFC2C6D8),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 24 * scale),

                    // Form (sin Column fijo que desborde)
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _FieldBlock(
                            label: 'FULL NAME',
                            hintText: 'John Doe',
                            iconColor: const Color(0xFF424655),
                            iconSize: 16 * scale,
                            inputHeight: 57 * scale,
                            inputPadY: 18 * scale,
                            inputPadX: 16 * scale,
                            inputRadius: 4 * scale,
                            borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                            borderWidth: 1,
                            labelIndentLeft: 4 * scale,
                            scale: scale,
                          ),
                          SizedBox(height: 24 * scale),
                          _FieldBlock(
                            label: 'EMAIL ADDRESS',
                            hintText: 'alex.vance@tech.com',
                            iconColor: const Color(0xFF65DAFF),
                            iconSize: 16 * scale,
                            inputHeight: 58 * scale,
                            inputPadY: 16 * scale,
                            inputPadX: 16 * scale,
                            inputRadius: 4 * scale,
                            borderColor: const Color.fromRGBO(101, 218, 255, 0.5),
                            borderWidth: 1,
                            labelIndentLeft: 4 * scale,
                            scale: scale,
                          ),
                          SizedBox(height: 4 * scale),
                          _PasswordBlock(
                            label: 'PASSWORD',
                            hintText: '••••••••••••••',
                            strengthColor: const Color(0xFF65DAFF),
                            strengthOverlay: const Color.fromRGBO(66, 70, 85, 0.2),
                            inputHeight: 57 * scale,
                            inputPadY: 18 * scale,
                            inputPadX: 16 * scale,
                            inputRadius: 4 * scale,
                            borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                            scale: scale,
                            showStrength: true,
                          ),
                          SizedBox(height: 4 * scale),
                          _PasswordBlock(
                            label: 'CONFIRM PASSWORD',
                            hintText: '••••••••••••••',
                            strengthColor: const Color(0xFF65DAFF),
                            strengthOverlay: const Color.fromRGBO(66, 70, 85, 0.2),
                            inputHeight: 57 * scale,
                            inputPadY: 18 * scale,
                            inputPadX: 16 * scale,
                            inputRadius: 4 * scale,
                            borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                            scale: scale,
                            showStrength: false,
                          ),

                          SizedBox(height: 24 * scale),

                          SizedBox(
                            width: formW,
                            height: 72 * scale,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/etapa2/login');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5B8CFF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8 * scale),
                                ),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16 * scale,
                                  color: const Color(0xFF002565),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 8 * scale),
                          _TermsAndFooter(scale: scale, width: formW),
                          SizedBox(height: 8 * scale),
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
    );
  }
}

class _FieldBlock extends StatelessWidget {
  const _FieldBlock({
    required this.label,
    required this.hintText,
    required this.iconColor,
    required this.iconSize,
    required this.inputHeight,
    required this.inputPadY,
    required this.inputPadX,
    required this.inputRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.labelIndentLeft,
    required this.scale,
  });

  final String label;
  final String hintText;
  final Color iconColor;
  final double iconSize;
  final double inputHeight;
  final double inputPadY;
  final double inputPadX;
  final double inputRadius;
  final Color borderColor;
  final double borderWidth;
  final double labelIndentLeft;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 344 * scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: labelIndentLeft),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 16 / 12,
                color: Color(0xFFC2C6D8),
              ),
            ),
          ),
          SizedBox(height: 4 * scale),
          Stack(
            children: [
              Container(
                height: inputHeight,
                padding: EdgeInsets.symmetric(
                  vertical: inputPadY,
                  horizontal: inputPadX,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0E16),
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(inputRadius),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    hintText,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * scale,
                      height: 19 / 16,
                      color: const Color(0xFF8C90A1),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: inputHeight * 0.2931,
                bottom: inputHeight * 0.2931,
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(color: iconColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PasswordBlock extends StatelessWidget {
  const _PasswordBlock({
    required this.label,
    required this.hintText,
    required this.strengthColor,
    required this.strengthOverlay,
    required this.inputHeight,
    required this.inputPadY,
    required this.inputPadX,
    required this.inputRadius,
    required this.borderColor,
    required this.scale,
    required this.showStrength,
  });

  final String label;
  final String hintText;
  final Color strengthColor;
  final Color strengthOverlay;
  final double inputHeight;
  final double inputPadY;
  final double inputPadX;
  final double inputRadius;
  final Color borderColor;
  final double scale;
  final bool showStrength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 344 * scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4 * scale),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w500,
                fontSize: 12 * scale,
                height: 16 / (12 * scale),
                color: const Color(0xFFC2C6D8),
              ),
            ),
          ),
          SizedBox(height: 4 * scale),
          Stack(
            children: [
              Container(
                height: inputHeight,
                padding: EdgeInsets.symmetric(
                  vertical: inputPadY,
                  horizontal: inputPadX,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0E16),
                  borderRadius: BorderRadius.circular(inputRadius),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    hintText,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * scale,
                      height: 19 / 16,
                      color: const Color(0xFF8C90A1),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: inputHeight * 0.2931,
                bottom: inputHeight * 0.2931,
                child: Container(
                  width: 16 * scale,
                  height: 21 * scale,
                  decoration: const BoxDecoration(color: Color(0xFF8C90A1)),
                ),
              ),
            ],
          ),
          if (showStrength) ...[
            SizedBox(height: 4 * scale),
            SizedBox(
              height: 4 * scale,
              width: 344 * scale,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: strengthColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: strengthColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: strengthColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: strengthOverlay,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 4 * scale),
          ],
        ],
      ),
    );
  }
}

class _TermsAndFooter extends StatelessWidget {
  const _TermsAndFooter({required this.scale, required this.width});
  final double scale;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48 * scale,
          width: width,
          child: Stack(
            children: [
              Positioned(
                left: (width - 230.41 * scale) / 2,
                top: 0,
                width: 230.41 * scale,
                child: Center(
                  child: Text(
                    'Terms',
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 12 * scale,
                      height: 16 / 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFC2C6D8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (width - 151.21 * scale) / 2 - 36.01 * scale,
                top: 16 * scale,
                width: 151.21 * scale,
                child: Text(
                  'Link → Privacy Protocol',
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 12 * scale,
                    height: 16 / 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB2C5FF),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 16 * scale,
                width: 147.63 * scale,
                child: Center(
                  child: Text(
                    'Link',
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 12 * scale,
                      height: 16 / 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB2C5FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 51 * scale,
          width: width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.77 * scale, vertical: 24 * scale),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color.fromRGBO(66, 70, 85, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Already have an account?',
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
        ),
      ],
    );
  }
}

