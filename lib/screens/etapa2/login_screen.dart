import 'dart:ui';

import 'package:flutter/material.dart';

/// Login (Etapa 2) - reconstrucción full UI/UX en Flutter (sin usar SVG como imagen).
/// Responsive con `scale = (width/390).clamp(0.85, 1.15)`.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double artW = 426 * scale;
    final double artH = 922 * scale;

    final double headerH = 65 * scale;
    final double paddingMainTop = 64 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Center(
        child: SizedBox(
          width: artW,
          height: artH,
          child: Stack(
            children: [
              // Ambient aura (Subtle Glowing Cyan Aura)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 500 * scale,
                    height: 500 * scale,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.75,
                        colors: [
                          const Color.fromRGBO(101, 218, 255, 0.08),
                          const Color.fromRGBO(101, 218, 255, 0.0),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                  ),
                ),
              ),

              // Header (TopAppBar)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: IgnorePointer(
                  child: Container(
                    height: headerH,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: DecoratedBox(
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
                          ),
                        ),
                        Positioned.fill(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12 * scale, sigmaY: 12 * scale),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                            child: Row(
                              children: [
                                Container(
                                  width: 32 * scale,
                                  height: 32 * scale,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12 * scale),
                                    border: Border.all(color: Colors.transparent),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 16 * scale,
                                      height: 16 * scale,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFB2C5FF),
                                        borderRadius: BorderRadius.circular(3 * scale),
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
                      ],
                    ),
                  ),
                ),
              ),

              // Main Canvas
              Positioned.fill(
                top: paddingMainTop,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  child: Column(
                    children: [
                      // Welcome Section
                      SizedBox(height: 0),
                      SizedBox(
                        width: 394 * scale,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome Back',
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
                            SizedBox(height: 8 * scale),
                            Text(
                              'Sign in to continue.',
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
                      SizedBox(height: 18 * scale),

                      // Login Card (glass)
                      SizedBox(
                        width: 394 * scale,
                        height: 570 * scale,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8 * scale),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(22, 27, 34, 0.7),
                                      borderRadius: BorderRadius.circular(8 * scale),
                                      border: Border.all(
                                        color: const Color.fromRGBO(66, 70, 85, 0.3),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8 * scale),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8 * scale),
                                    color: Colors.white.withOpacity(0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 25 * scale,
                                        offset: const Offset(0, 20),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10 * scale,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32 * scale, 48 * scale, 32 * scale, 32 * scale),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Form
                                  SizedBox(
                                    width: 328 * scale,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _LoginEmailField(scale: scale, onTap: () {}),
                                        SizedBox(height: 24 * scale),
                                        _LoginPasswordField(scale: scale, onForgot: () {}),
                                        SizedBox(height: 16 * scale),
                                        _OptionsRow(scale: scale),
                                        SizedBox(height: 16 * scale),
                                        _ActionButtons(scale: scale, onPrimary: () {
                                          Navigator.of(context).pushNamed('/etapa2/verify-identity');
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      // Footer Info
                      SizedBox(
                        width: 394 * scale,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'New to EmSafe? Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16 * scale,
                                height: 24 / 16,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8 * scale),

                      // Compliance placeholders
                      SizedBox(
                        width: 394 * scale,
                        height: 32 * scale,
                        child: Opacity(
                          opacity: 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _ComplianceLogo(scale: scale),
                              SizedBox(width: 24 * scale),
                              _ComplianceLogo(scale: scale),
                            ],
                          ),
                        ),
                      ),

                      // Bottom separation
                      SizedBox(height: 12 * scale),
                      Container(
                        width: 426 * scale,
                        height: 16 * scale,
                        color: const Color(0xFF0B0E16),
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

class _ComplianceLogo extends StatelessWidget {
  const _ComplianceLogo({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32 * scale,
      height: 32 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8 * scale),
      ),
    );
  }
}

class _LoginEmailField extends StatelessWidget {
  const _LoginEmailField({required this.scale, required this.onTap});
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328 * scale,
      height: 84 * scale,
      child: Stack(
        children: [
          Positioned(
            left: 4 * scale,
            top: 0,
            child: Text(
              'Email Address',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w500,
                fontSize: 12 * scale,
                height: 16 / 12,
                letterSpacing: 0.6 * scale,
                color: const Color(0xFFC2C6D8),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 20 * scale,
            child: Container(
              height: 64 * scale,
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFF0B0E16),
                border: Border.all(
                  color: const Color.fromRGBO(66, 70, 85, 0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4 * scale),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20 * scale,
                    height: 20 * scale,
                    decoration: const BoxDecoration(color: Color(0xFF8C90A1)),
                  ),
                  SizedBox(width: 8 * scale),
                  Text(
                    'name@organization.com',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * scale,
                      height: 19 / 16,
                      color: Colors.black.withOpacity(0.0),
                    ),
                  ),
                  // Use correct color like CSS via fixed color
                  Expanded(
                    child: Text(
                      'name@organization.com',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16 * scale,
                        height: 19 / 16,
                        color: const Color.fromRGBO(140, 144, 161, 0.5),
                      ),
                    ),
                  ),
                  SizedBox(width: 0),
                ],
              ),
            ),
          ),
          // Invisible tap area
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginPasswordField extends StatelessWidget {
  const _LoginPasswordField({required this.scale, required this.onForgot});
  final double scale;
  final VoidCallback onForgot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328 * scale,
      height: 84 * scale,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                left: 4 * scale,
                right: 4 * scale,
                top: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.w500,
                        fontSize: 12 * scale,
                        height: 16 / 12,
                        letterSpacing: 0.6 * scale,
                        color: const Color(0xFFC2C6D8),
                      ),
                    ),
                    GestureDetector(
                      onTap: onForgot,
                      child: Text(
                        'Forgot',
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
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 20 * scale,
                child: Container(
                  height: 64 * scale,
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0E16),
                    border: Border.all(
                      color: const Color.fromRGBO(66, 70, 85, 0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4 * scale),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16 * scale,
                        height: 21 * scale,
                        color: const Color(0xFF8C90A1),
                      ),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: Text(
                          '••••••••',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16 * scale,
                            height: 19 / 16,
                            color: const Color.fromRGBO(140, 144, 161, 0.5),
                          ),
                        ),
                      ),
                      // eye icon
                      Container(
                        width: 22 * scale,
                        height: 15 * scale,
                        color: const Color(0xFF8C90A1),
                      ),
                    ],
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

class _OptionsRow extends StatelessWidget {
  const _OptionsRow({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328 * scale,
      height: 24 * scale,
      child: Row(
        children: [
          Container(
            width: 16 * scale,
            height: 16 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF0B0E16),
              border: Border.all(color: const Color(0xFF424655), width: 1),
              borderRadius: BorderRadius.circular(2 * scale),
            ),
          ),
          SizedBox(width: 8 * scale),
          Text(
            'Remember me',
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
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.scale, required this.onPrimary});
  final double scale;
  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328 * scale,
      height: 208 * scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0),
          // Primary button B2C5FF
          SizedBox(
            height: 64 * scale,
            width: 328 * scale,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.002),
                      borderRadius: BorderRadius.circular(4 * scale),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(178, 197, 255, 0.1),
                          blurRadius: 10 * scale,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ElevatedButton(
                    onPressed: onPrimary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB2C5FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4 * scale),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 18 * scale,
                          height: 18 * scale,
                          color: const Color(0xFF002B73),
                        ),
                        SizedBox(width: 8 * scale),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 24 * scale,
                            height: 32 / 24,
                            color: const Color(0xFF002B73),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16 * scale),

          // Divider + OR text
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1 * scale,
                  color: const Color.fromRGBO(66, 70, 85, 0.3),
                ),
              ),
              SizedBox(width: 8 * scale),
              Text(
                'OR',
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontWeight: FontWeight.w500,
                  fontSize: 12 * scale,
                  height: 16 / 12,
                  color: const Color(0xFF8C90A1),
                  letterSpacing: 0.0,
                ),
              ),
              SizedBox(width: 8 * scale),
              Expanded(
                child: Container(
                  height: 1 * scale,
                  color: const Color.fromRGBO(66, 70, 85, 0.3),
                ),
              ),
            ],
          ),

          SizedBox(height: 16 * scale),

          // Secondary outlined button
          SizedBox(
            height: 64 * scale,
            width: 328 * scale,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF424655)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4 * scale),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 26.67 * scale,
                    height: 26.67 * scale,
                    decoration: const BoxDecoration(color: Color(0xFF65DAFF)),
                  ),
                  SizedBox(width: 16 * scale),
                  Text(
                    'Continue with EmSafe',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 18 * scale,
                      height: 28 / 18,
                      color: const Color(0xFFE1E2EE),
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

