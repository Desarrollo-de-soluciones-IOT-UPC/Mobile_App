import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class SplashEmSafeUpdatedScreen extends StatelessWidget {
  const SplashEmSafeUpdatedScreen({super.key});

  static const String bottomText =
      'Track electromagnetic\nradiation in real time.';

  static const String descriptionText =
      'Stay aware of your surroundings with live precision monitoring. Our advanced sensors detect invisible waves to keep your environment secure.';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // Baseline del diseño: iPhone 390x884. Escalamos proporcionalmente.
    final double scale = (size.width / 390).clamp(0.85, 1.15);

    final double headerHeight = (57 * scale).clamp(48, 70);
    final double bentoWidth = (280 * scale).clamp(240, 320);
    final double bentoHeight = (199 * scale).clamp(160, 240);
    final double footerPad = (24 * scale).clamp(16, 28);

    final double leftPad = (24 * scale).clamp(16, 28);
    final double rightPad = (24 * scale).clamp(16, 28);
    final double topPad = (57 * scale).clamp(32, 90);

    final double pageWidth = (bentoWidth + 2 * 24 * scale)
        .clamp(320, size.width - 24 * 2);

    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF10131B),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: headerHeight,
                      child: _Header(height: headerHeight),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - headerHeight,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: topPad,
                              left: leftPad,
                              right: rightPad,
                            ),
                            child: SizedBox(
                              width: pageWidth,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: _BentoCard(
                                      width: bentoWidth,
                                      height: bentoHeight,
                                      scale: scale,
                                    ),
                                  ),
                                  SizedBox(height: (20 * scale).clamp(12, 40)),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: const Color(0xFFE1E2EE),
                                        fontSize: (30 * scale).clamp(22, 36),
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Track electromagnetic\n',
                                        ),
                                        TextSpan(
                                          text: 'radiation',
                                          style: TextStyle(
                                            color: const Color(0xFFB2C5FF),
                                            fontSize: (30 * scale).clamp(22, 36),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' in real time.',
                                          style: TextStyle(
                                            color: const Color(0xFFE1E2EE),
                                            fontSize: (30 * scale).clamp(22, 36),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: (10 * scale).clamp(8, 18),
                                    ),
                                    child: Text(
                                      descriptionText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFFC2C6D8),
                                        fontSize: (18 * scale).clamp(14, 20),
                                        height: 1.6,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: (8 * scale).clamp(0, 24)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(29, 31, 40, 0.6),
                        border: Border(
                          top: BorderSide(color: Color(0x1A424655)),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        (24 * scale).clamp(16, 28),
                        footerPad,
                        (24 * scale).clamp(16, 28),
                        (40 * scale).clamp(20, 48),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              _dot(active: true, scale: scale),
                              SizedBox(width: 8 * scale),
                              _dot(active: false, scale: scale),
                              SizedBox(width: 8 * scale),
                              _dot(active: false, scale: scale),
                              SizedBox(width: 8 * scale),
                              _dot(active: false, scale: scale),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: (56 * scale).clamp(46, 70),
                            child: FilledButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.onboardingSmartAlerts,
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFB2C5FF),
                                foregroundColor: const Color(0xFF002B73),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12 * scale),
                                ),
                              ),
                              child: const Text('Next'),
                            ),
                          ),
                          SizedBox(height: (12 * scale).clamp(8, 16)),
                          Text(
                            'Already have an account?\nSign In',
                            style: TextStyle(
                              color: const Color(0xFFC2C6D8),
                              fontSize: (16 * scale).clamp(14, 18),
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _dot({required bool active, required double scale}) {
    final w = (active ? 32 : 12).clamp(10, 32) * scale;
    return Container(
      width: w,
      height: (6 * scale).clamp(4, 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFB2C5FF) : const Color(0xFF32343E),
        borderRadius: BorderRadius.circular(12 * scale),
        boxShadow: active
            ? const [
                BoxShadow(
                  color: Color(0x66B2C5FF),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double height;

  const _Header({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (24 * (height / 57)).clamp(16, 28),
      ),
      decoration: const BoxDecoration(
        color: Color(0x8010131B),
        border: Border(
          bottom: BorderSide(
            color: Color(0x33424655),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFB2C5FF),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'EmSafe',
                style: TextStyle(
                  color: Color(0xFFB2C5FF),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.onboardingSmartAlerts,
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final double width;
  final double height;
  final double scale;

  const _BentoCard({
    super.key,
    required this.width,
    required this.height,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(25, 27, 36, 0.6),
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(
          color: const Color.fromRGBO(178, 197, 255, 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 138 * scale,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CURRENT EXPOSURE',
                      style: TextStyle(
                        color: Color(0xFFC2C6D8),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    const Text(
                      '42.5 µW/m²',
                      style: TextStyle(
                        color: Color(0xFFB2C5FF),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                    Container(
                      height: 31 * scale,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12 * scale,
                        vertical: 6 * scale,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(46, 160, 67, 0.1),
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(
                          color: const Color.fromRGBO(46, 160, 67, 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFF2EA043),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'SAFE',
                            style: TextStyle(
                              color: Color(0xFF2EA043),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 104 * scale),
            ],
          ),
          const Spacer(),
          Container(
            height: 4 * scale,
            width: 230 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF32343E),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * scale),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2EA043),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '0.0',
                style: TextStyle(
                  color: Color(0x99C2C6D8),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '100.0',
                style: TextStyle(
                  color: Color(0x99C2C6D8),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

