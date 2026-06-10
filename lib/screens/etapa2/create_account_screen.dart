import 'dart:ui';

import 'package:flutter/material.dart';

/// Create Account (Etapa 2)
/// Responsive profesional: sin alturas rígidas/artboards fijos.
/// - Scroll fluido para teclado.
/// - Campos reales (TextFormField) en vez de cajas simuladas.
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Stack(
        children: [
          // Ambient background
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
                                  // Title + subtitle
                                  Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 32 * scale,
                                      height: 40 / (32),
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

                                  // Form
                                  _FieldBlock(
                                    label: 'FULL NAME',
                                    hintText: 'John Doe',
                                    icon: Icons.person_outline,
                                    scale: scale,
                                  ),
                                  SizedBox(height: 24 * scale),

                                  _FieldBlock(
                                    label: 'EMAIL ADDRESS',
                                    hintText: 'alex.vance@tech.com',
                                    icon: Icons.mail_outline,
                                    scale: scale,
                                  ),
                                  SizedBox(height: 16 * scale),

                                  _PasswordBlock(
                                    label: 'PASSWORD',
                                    hintText: '••••••••••••••',
                                    scale: scale,
                                    showStrength: true,
                                  ),
                                  SizedBox(height: 16 * scale),

                                  _PasswordBlock(
                                    label: 'CONFIRM PASSWORD',
                                    hintText: '••••••••••••••',
                                    scale: scale,
                                    showStrength: false,
                                  ),

                                  SizedBox(height: 24 * scale),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 56 * scale,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/etapa2/login');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF5B8CFF),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8 * scale),
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
                                  _TermsAndFooter(scale: scale),
                                  SizedBox(height: 8 * scale),
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

class _FieldBlock extends StatelessWidget {
  const _FieldBlock({
    required this.label,
    required this.hintText,
    required this.icon,
    required this.scale,
  });

  final String label;
  final String hintText;
  final IconData icon;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontWeight: FontWeight.w500,
            fontSize: 12 * scale,
            height: 16 / 12,
            color: const Color(0xFFC2C6D8),
          ),
        ),
        SizedBox(height: 4 * scale),
        TextFormField(
          keyboardType: label == 'EMAIL ADDRESS'
              ? TextInputType.emailAddress
              : TextInputType.name,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF8C90A1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16 * scale,
            ),
            filled: true,
            fillColor: const Color(0xFF0B0E16),
            contentPadding: EdgeInsets.symmetric(
              vertical: 18 * scale,
              horizontal: 16 * scale,
            ),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF65DAFF),
              size: 20 * scale,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6 * scale),
              borderSide: const BorderSide(
                color: Color.fromRGBO(66, 70, 85, 0.35),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6 * scale),
              borderSide: const BorderSide(
                color: Color.fromRGBO(91, 140, 255, 1),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordBlock extends StatelessWidget {
  const _PasswordBlock({
    required this.label,
    required this.hintText,
    required this.scale,
    required this.showStrength,
  });

  final String label;
  final String hintText;
  final double scale;
  final bool showStrength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontWeight: FontWeight.w500,
            fontSize: 12 * scale,
            height: 16 / (12),
            color: const Color(0xFFC2C6D8),
          ),
        ),
        SizedBox(height: 4 * scale),
        TextFormField(
          obscureText: true,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF8C90A1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16 * scale,
            ),
            filled: true,
            fillColor: const Color(0xFF0B0E16),
            contentPadding: EdgeInsets.symmetric(
              vertical: 18 * scale,
              horizontal: 16 * scale,
            ),
            suffixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF8C90A1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6 * scale),
              borderSide: const BorderSide(
                color: Color.fromRGBO(66, 70, 85, 0.35),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6 * scale),
              borderSide: const BorderSide(
                color: Color.fromRGBO(91, 140, 255, 1),
                width: 1.2,
              ),
            ),
          ),
        ),

        if (showStrength) ...[
          SizedBox(height: 8 * scale),
          SizedBox(
            height: 6 * scale,
            child: Row(
              children: [
                _StrengthPill(color: const Color(0xFF65DAFF), radius: 12),
                SizedBox(width: 6 * scale),
                _StrengthPill(color: const Color(0xFF65DAFF), radius: 12),
                SizedBox(width: 6 * scale),
                _StrengthPill(color: const Color(0xFF65DAFF), radius: 12),
                SizedBox(width: 6 * scale),
                _StrengthPill(
                  color: const Color.fromRGBO(101, 218, 255, 0.2),
                  radius: 12,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _StrengthPill extends StatelessWidget {
  const _StrengthPill({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class _TermsAndFooter extends StatelessWidget {
  const _TermsAndFooter({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48 * scale,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
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
                left: 0,
                right: 0,
                top: 16 * scale,
                child: Center(
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
              ),
            ],
          ),
        ),
        SizedBox(
          height: 51 * scale,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25.77 * scale,
              vertical: 24 * scale,
            ),
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

