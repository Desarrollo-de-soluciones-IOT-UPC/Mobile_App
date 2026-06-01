import 'package:flutter/material.dart';

/// Splash que navega automáticamente en [duration].
/// Versión mejorada que soporta tanto assets PNG como widgets personalizados.
class SplashAutoNavigate extends StatefulWidget {
  /// Si se proporciona, muestra este asset como imagen de fondo
  final String? asset;
  
  /// Si se proporciona, muestra este widget en lugar del asset
  final Widget? child;
  
  final Duration duration;
  final String nextRoute;

  const SplashAutoNavigate({
    super.key,
    this.asset,
    this.child,
    required this.duration,
    required this.nextRoute,
  }) : assert(asset != null || child != null, 'asset o child debe ser proporcionado');

  @override
  State<SplashAutoNavigate> createState() => _SplashAutoNavigateState();
}

class _SplashAutoNavigateState extends State<SplashAutoNavigate> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: widget.child ??
            Image.asset(
              widget.asset!,
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}

