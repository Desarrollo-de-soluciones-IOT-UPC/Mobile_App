import 'dart:ui';

import 'package:flutter/material.dart';

/// Create Account (Etapa 2) - reconstrucción full UI/UX en Flutter.
/// Basado en el layout/valores que enviaste en CSS.
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    // Tamaño base del diseño (referencia):
    // - artboard width ~ 426, height ~ 1068
    // - overlay card width 394, interior form width 344

    final double screenW = 426 * scale;
    final double screenH = 1068 * scale;

    final double cardW = 394 * scale;
    final double cardH = 877 * scale;

    final double formW = 344 * scale;


    final double paddingMainX = 16 * scale;
    final double paddingMainTop = 63.5 * scale;

    final double overlayPad = 24 * scale;
    final double overlayGap = 32 * scale;
    final double overlayRadius = 8 * scale;

    final double titleFont = 32 * scale;
    final double titleLineH = 40 * scale;

    final double bodyFont = 16 * scale;

    final double inputH = 57 * scale;
    final double inputPadY = 18 * scale;
    final double inputPadX = 16 * scale;
    final double inputRadius = 4 * scale;

    final double strengthW = 344 * scale;
    final double strengthBarH = 4 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Center(
        child: SizedBox(
          width: screenW,
          height: screenH,
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
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 60 * scale, sigmaY: 60 * scale),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),

              // Main canvas
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingMainX,
                  vertical: paddingMainTop,
                ),
                child: Center(
                  child: SizedBox(
                    width: cardW,
                    height: cardH,
                    child: Stack(
                      children: [
                        // Overlay card
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(overlayRadius),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x16161B22), // rgba(22,27,34,0.7) aprox.
                                  borderRadius: BorderRadius.circular(overlayRadius),
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
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.002),
                                          borderRadius:
                                              BorderRadius.circular(overlayRadius),
                                        ),
                                      ),
                                    ),

                                    // Content
                                    Positioned.fill(
                                      child: Padding(
                                        padding: EdgeInsets.all(overlayPad),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 0),
                                            // Header
                                            SizedBox(
                                              width: formW,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Create Account',
                                                    style: TextStyle(
                                                      fontSize: titleFont,
                                                      height: titleLineH / titleFont,
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
                                                      fontSize: bodyFont,
                                                      height: 24 / 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: const Color(0xFFC2C6D8),
                                                      fontFamily: 'Inter',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: overlayGap - 24 * scale),

                                            // Form
                                            SizedBox(
                                              width: formW,
                                              height: 605 * scale,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  _FieldBlock(
                                                    label: 'FULL NAME',
                                                    hintText: 'John Doe',
                                                    iconColor: const Color(0xFF424655),
                                                    iconSize: 16 * scale,
                                                    iconIsFilled: true,
                                                    inputHeight: inputH,
                                                    inputPadY: inputPadY,
                                                    inputPadX: inputPadX,
                                                    inputRadius: inputRadius,
                                                    borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                                                    borderWidth: 1,
                                                    labelIndentLeft: 4 * scale,
                                                    // simple fake scroll container (for overflow visual only)
                                                    useScrollForText: false,
                                                  ),
                                                  SizedBox(height: 24 * scale),
                                                  _EmailBlock(
                                                    label: 'EMAIL ADDRESS',
                                                    hintText: 'alex.vance@tech.com',
                                                    iconColor: const Color(0xFF65DAFF),
                                                    inputHeight: 58 * scale,
                                                    inputPadY: 16 * scale,
                                                    inputPadX: 16 * scale,
                                                    inputRadius: inputRadius,
                                                  ),
                                                  SizedBox(height: 4 * scale),
                                                  _PasswordBlock(
                                                    label: 'PASSWORD',
                                                    hintText: '••••••••••••••',
                                                    // strength meter uses 4 segments with overlay
                                                    strengthColor: const Color(0xFF65DAFF),
                                                    strengthOverlay: const Color.fromRGBO(66, 70, 85, 0.2),
                                                    strengthW: strengthW,
                                                    strengthBarH: strengthBarH,
                                                    iconColor: const Color(0xFF424655),
                                                    inputHeight: 57 * scale,
                                                    inputPadY: 18 * scale,
                                                    inputPadX: 16 * scale,
                                                    inputRadius: inputRadius,
                                                    borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                                                  ),

                                                  SizedBox(height: 4 * scale),
                                                  // confirm password
                                                  _PasswordBlock(
                                                    label: 'CONFIRM PASSWORD',
                                                    hintText: '••••••••••••••',
                                                    strengthColor: const Color(0xFF65DAFF),
                                                    strengthOverlay: const Color.fromRGBO(66, 70, 85, 0.2),
                                                    strengthW: strengthW,
                                                    strengthBarH: strengthBarH,
                                                    iconColor: const Color(0xFF424655),
                                                    inputHeight: 57 * scale,
                                                    inputPadY: 18 * scale,
                                                    inputPadX: 16 * scale,
                                                    inputRadius: inputRadius,
                                                    borderColor: const Color.fromRGBO(66, 70, 85, 0.3),
                                                    // confirm doesn't show meter in your snippet; keep it minimal.
                                                    showStrength: false,
                                                  ),

                                                  // CTA button block + terms/footer
                                                  SizedBox(height: 24 * scale),
                                                  _PrimaryCTA(
                                                    width: formW,
                                                    scale: scale,
                                                    onPressed: () {
                                                      Navigator.of(context).pushNamed('/etapa2/login');
                                                    },
                                                  ),
                                                  SizedBox(height: 8 * scale),
                                                  _TermsAndFooter(
                                                    width: formW,
                                                    scale: scale,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Header top app bar (visual only)
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: -(20 * scale),
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
                                                    borderRadius: BorderRadius.circular(12 * scale),
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
                        ),
                      ],
                    ),
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

class _FieldBlock extends StatelessWidget {
  const _FieldBlock({
    required this.label,
    required this.hintText,
    required this.iconColor,
    required this.iconSize,
    required this.iconIsFilled,
    required this.inputHeight,
    required this.inputPadY,
    required this.inputPadX,
    required this.inputRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.labelIndentLeft,
    required this.useScrollForText,
  });

  final String label;
  final String hintText;
  final Color iconColor;
  final double iconSize;
  final bool iconIsFilled;
  final double inputHeight;
  final double inputPadY;
  final double inputPadX;
  final double inputRadius;
  final Color borderColor;
  final double borderWidth;
  final double labelIndentLeft;
  final bool useScrollForText;

  @override
  Widget build(BuildContext context) {
    // Layout exact (aprox) según tu CSS.
    return SizedBox(
      width: 344,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: labelIndentLeft),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 16 / 12,
                letterSpacing: 0,
                color: Color(0xFFC2C6D8),
              ),
            ),
          ),
          SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: inputHeight,
                padding: EdgeInsets.symmetric(vertical: inputPadY, horizontal: inputPadX),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0E16),
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(inputRadius),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    hintText,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 19 / 16,
                      color: Color(0xFF8C90A1),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: inputHeight * 0.2931,
                bottom: inputHeight * 0.2931,
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailBlock extends StatelessWidget {
  const _EmailBlock({
    required this.label,
    required this.hintText,
    required this.iconColor,
    required this.inputHeight,
    required this.inputPadY,
    required this.inputPadX,
    required this.inputRadius,
  });

  final String label;
  final String hintText;
  final Color iconColor;
  final double inputHeight;
  final double inputPadY;
  final double inputPadX;
  final double inputRadius;

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.sizeOf(context).width / 390).clamp(0.85, 1.15);

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
                height: 16 / 12,
                color: const Color(0xFFC2C6D8),
              ),
            ),
          ),
          SizedBox(height: 4 * scale),
          Stack(
            children: [
              Container(
                height: inputHeight * scale,
                padding: EdgeInsets.symmetric(
                  vertical: inputPadY * scale,
                  horizontal: inputPadX * scale,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0E16),
                  borderRadius: BorderRadius.circular(inputRadius * scale),
                  border: Border.all(
                    color: const Color.fromRGBO(101, 218, 255, 0.5),
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    hintText,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * scale,
                      height: 24 / 16,
                      color: const Color(0xFFE1E2EE),
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: (inputHeight * scale) * 0.2931,
                bottom: (inputHeight * scale) * 0.2931,
                child: Container(
                  width: 20 * scale,
                  height: 20 * scale,
                  decoration: BoxDecoration(color: iconColor),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 4 * scale),
            child: Text(
              'Verified secure corporate domain',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w500,
                fontSize: 12 * scale,
                height: 16 / 12,
                color: const Color(0xFF65DAFF),
              ),
            ),
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
    required this.strengthW,
    required this.strengthBarH,
    required this.iconColor,
    required this.inputHeight,
    required this.inputPadY,
    required this.inputPadX,
    required this.inputRadius,
    required this.borderColor,
    this.showStrength = true,
  });

  final String label;
  final String hintText;
  final Color strengthColor;
  final Color strengthOverlay;
  final double strengthW;
  final double strengthBarH;
  final Color iconColor;
  final double inputHeight;
  final double inputPadY;
  final double inputPadX;
  final double inputRadius;
  final Color borderColor;
  final bool showStrength;

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.sizeOf(context).width / 390).clamp(0.85, 1.15);

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
                height: 16 / 12,
                color: const Color(0xFFC2C6D8),
              ),
            ),
          ),
          SizedBox(height: 4 * scale),
          Stack(
            children: [
              Container(
                height: inputHeight * scale,
                padding: EdgeInsets.symmetric(
                  vertical: inputPadY * scale,
                  horizontal: inputPadX * scale,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0E16),
                  borderRadius: BorderRadius.circular(inputRadius * scale),
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
                  ),
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: (inputHeight * scale) * 0.2931,
                bottom: (inputHeight * scale) * 0.2931,
                child: Container(
                  width: (label.contains('CONFIRM') ? 22 : 16) * scale,
                  height: (label.contains('CONFIRM') ? 21 : 16) * scale,
                  decoration: BoxDecoration(color: iconColor),
                ),
              ),
            ],
          ),
          if (showStrength) SizedBox(height: 4 * scale),
          if (showStrength)
            SizedBox(
              height: strengthBarH * scale,
              width: strengthW * scale,
              child: Row(
                children: [
                  _StrengthSegment(color: strengthColor, overlay: true, grow: 1),
                  _StrengthSegment(color: strengthColor, overlay: true, grow: 1),
                  _StrengthSegment(color: strengthColor, overlay: true, grow: 1),
                  _StrengthSegment(color: strengthOverlay, overlay: false, grow: 1),
                ],
              ),
            ),
          SizedBox(height: 4 * scale),
        ],
      ),
    );
  }
}

class _StrengthSegment extends StatelessWidget {
  const _StrengthSegment({
    required this.color,
    required this.overlay,
    required this.grow,
  });

  final Color color;
  final bool overlay;
  final int grow;

  @override
  Widget build(BuildContext context) {
    // each segment in your CSS: width 81, height 4. We'll scale with flex.
    return Expanded(
      flex: grow,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 4 * ((MediaQuery.sizeOf(context).width / 390).clamp(0.85, 1.15)),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (overlay)
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _PrimaryCTA extends StatelessWidget {
  const _PrimaryCTA({
    required this.width,
    required this.scale,
    required this.onPressed,
  });

  final double width;
  final double scale;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 72 * scale,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8 * scale),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(91, 140, 255, 0.2),
                    blurRadius: 10 * scale,
                    offset: Offset(0, 10 * scale),
                  ),
                  BoxShadow(
                    color: const Color.fromRGBO(91, 140, 255, 0.2),
                    blurRadius: 6 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: 16 * scale),
              child: SizedBox(
                height: 56 * scale,
                child: ElevatedButton(
                  onPressed: onPressed,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsAndFooter extends StatelessWidget {
  const _TermsAndFooter({
    required this.width,
    required this.scale,
  });

  final double width;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terms
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

          // Footer link
          SizedBox(
            height: 51 * scale,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color.fromRGBO(66, 70, 85, 0.2),
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25.77 * scale, vertical: 24 * scale),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: -2 * scale,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16 * scale,
                            height: 24 / 16,
                            color: const Color(0xFF65DAFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

