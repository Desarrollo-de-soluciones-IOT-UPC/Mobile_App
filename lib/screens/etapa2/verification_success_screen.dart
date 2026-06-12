import 'dart:ui';

import 'package:flutter/material.dart';

import '../../routes/etapa2_routes.dart';

/// Verification Success (Etapa 2)
/// Estado final de verificacion antes de redirigir al dashboard.
class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.86, 1.12);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
                      child: Column(
                        children: [
                          SizedBox(height: 12 * scale),
                          _Header(scale: scale),
                          SizedBox(height: 86 * scale),
                          _VerifiedMark(scale: scale),
                          SizedBox(height: 26 * scale),
                          Text(
                            'Identity Verified',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w700,
                              fontSize: 30 * scale,
                              height: 1.12,
                              color: const Color(0xFFE9ECF7),
                              letterSpacing: -0.7,
                            ),
                          ),
                          SizedBox(height: 12 * scale),
                          Text(
                            'Your secure session is active. Redirecting\nyou to your workspace...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14 * scale,
                              height: 1.55,
                              color: const Color(0xFFC2C6D8),
                            ),
                          ),
                          SizedBox(height: 34 * scale),
                          SizedBox(
                            width: double.infinity,
                            height: 56 * scale,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(Etapa2Routes.goingToDashboard);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF00C0E9),
                                foregroundColor: const Color(0xFF002B35),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    7 * scale,
                                  ),
                                ),
                                textStyle: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17 * scale,
                                ),
                              ),
                              child: const Text('Go to Dashboard'),
                            ),
                          ),
                          SizedBox(height: 16 * scale),
                          _SecureHandshake(scale: scale),
                          SizedBox(height: 32 * scale),
                        ],
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

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40 * scale,
      child: Row(
        children: [
          Container(
            width: 18 * scale,
            height: 14 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFB2C5FF),
              borderRadius: BorderRadius.circular(3 * scale),
            ),
            child: Icon(
              Icons.health_and_safety,
              size: 11 * scale,
              color: const Color(0xFF0B0F19),
            ),
          ),
          SizedBox(width: 8 * scale),
          Text(
            'EMSafe',
            style: TextStyle(
              fontFamily: 'Sora',
              fontWeight: FontWeight.w700,
              fontSize: 19 * scale,
              color: const Color(0xFFB2C5FF),
              letterSpacing: -0.4,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12 * scale,
              vertical: 6 * scale,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 192, 233, 0.08),
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(
                color: const Color.fromRGBO(0, 192, 233, 0.22),
              ),
            ),
            child: Text(
              'SYSTEM LIVE',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontWeight: FontWeight.w600,
                fontSize: 9 * scale,
                letterSpacing: 1,
                color: const Color(0xFF65DAFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifiedMark extends StatelessWidget {
  const _VerifiedMark({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150 * scale,
      height: 150 * scale,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28 * scale),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 128 * scale,
                height: 128 * scale,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(22, 27, 34, 0.55),
                  borderRadius: BorderRadius.circular(28 * scale),
                  border: Border.all(
                    color: const Color.fromRGBO(101, 218, 255, 0.12),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(101, 218, 255, 0.16),
                      blurRadius: 34,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 78 * scale,
            height: 78 * scale,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(101, 218, 255, 0.08),
              borderRadius: BorderRadius.circular(9 * scale),
              border: Border.all(
                color: const Color.fromRGBO(101, 218, 255, 0.35),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(101, 218, 255, 0.2),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: const BoxDecoration(
              color: Color(0xFF65DAFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: const Color(0xFF0B2630),
              size: 34 * scale,
            ),
          ),
          Positioned(
            top: 12 * scale,
            right: 6 * scale,
            child: Container(
              width: 22 * scale,
              height: 22 * scale,
              decoration: const BoxDecoration(
                color: Color(0xFF00C0E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield_outlined,
                color: const Color(0xFF0B2630),
                size: 14 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecureHandshake extends StatelessWidget {
  const _SecureHandshake({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 6 * scale,
          height: 6 * scale,
          decoration: const BoxDecoration(
            color: Color(0xFF65DAFF),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8 * scale),
        Text(
          'SECURE HANDSHAKE COMPLETED',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 9 * scale,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: const Color(0xFF8C90A1),
          ),
        ),
      ],
    );
  }
}
