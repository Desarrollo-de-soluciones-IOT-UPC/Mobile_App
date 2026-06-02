import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class SplashOfficialBrandScreen extends StatelessWidget {
  const SplashOfficialBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SplashContent();
  }
}

class _SplashContent extends StatefulWidget {
  const _SplashContent();

  @override
  State<_SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContent>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _connectionController;
  late final Animation<double> _logoScale;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.splashUpdated);
      }
    });
  }

  void _setupAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _connectionController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _textController.forward();
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _connectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkNavy,
              const Color(0xFF101C2E),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.darkBg,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: AppTheme.primaryCyan.withValues(alpha: 0.22),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryCyan.withValues(alpha: 0.18),
                            blurRadius: 40,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: AppTheme.primaryCyan.withValues(alpha: 0.35),
                                width: 1.5,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.asset(
                              'assets/IMG_ETAPA_1/logo.jpeg',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _textOpacity,
                    child: Column(
                      children: [
                        const Text(
                          'EmSafe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: 80,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 46),
                        Text(
                          'MONITOR YOUR ENVIRONMENT.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.86),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'PROTECT YOUR FUTURE.',
                          style: const TextStyle(
                            color: AppTheme.primaryBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        ScaleTransition(
                          scale: Tween<double>(begin: 0.82, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _connectionController,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.darkBg.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: AppTheme.primaryBlue.withValues(alpha: 0.18),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'SECURING CONNECTION ...',
                                  style: TextStyle(
                                    color: AppTheme.primaryBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}




