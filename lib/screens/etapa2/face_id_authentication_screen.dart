import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../routes/etapa2_routes.dart';

class FaceIdAuthenticationScreen extends StatefulWidget {
  const FaceIdAuthenticationScreen({super.key});

  @override
  State<FaceIdAuthenticationScreen> createState() =>
      _FaceIdAuthenticationScreenState();
}

class _FaceIdAuthenticationScreenState
    extends State<FaceIdAuthenticationScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _available = false;
  bool _authenticating = false;
  String _status = 'Checking biometric availability';

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    if (kIsWeb) {
      setState(() {
        _available = false;
        _status = 'Web fallback available';
      });
      return;
    }

    try {
      final canCheck = await _auth.canCheckBiometrics;
      final supported = await _auth.isDeviceSupported();
      final biometrics = await _auth.getAvailableBiometrics();
      if (!mounted) return;
      setState(() {
        _available = canCheck && supported && biometrics.isNotEmpty;
        _status = _available
            ? 'Biometric authentication available'
            : 'Use code verification';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _available = false;
        _status = 'Use code verification';
      });
    }
  }

  Future<void> _authenticate() async {
    if (!_available) {
      Navigator.of(context).pushNamed(Etapa2Routes.verifyIdentity);
      return;
    }

    setState(() {
      _authenticating = true;
      _status = 'Authenticating';
    });

    try {
      final authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to register your EmSafe profile',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
      if (!mounted) return;
      setState(() {
        _authenticating = false;
        _status = authenticated
            ? 'Authentication successful'
            : 'Authentication failed';
      });
      if (authenticated) {
        Navigator.of(context).pushNamed(Etapa2Routes.verifyIdentity);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _authenticating = false;
        _status = 'Authentication failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = (size.width / 390).clamp(0.85, 1.15);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
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
                        padding: EdgeInsets.all(24 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0x0D161B22),
                          borderRadius: BorderRadius.circular(16 * scale),
                          border: Border.all(
                            color: const Color.fromRGBO(140, 144, 161, 0.15),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 40 * scale,
                              offset: Offset(0, 20 * scale),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: _StatusChip(
                                text: _available ? 'Available' : 'Fallback',
                                color: _available
                                    ? const Color(0xFF65DAFF)
                                    : const Color(0xFFB2C5FF),
                                scale: scale,
                              ),
                            ),
                            SizedBox(height: 18 * scale),
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
                              'Use local authentication or continue with code verification.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16 * scale,
                                height: 1.5,
                                color: const Color(0xFFC2C6D8),
                              ),
                            ),
                            SizedBox(height: 10 * scale),
                            Text(
                              _status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'JetBrains Mono',
                                fontWeight: FontWeight.w600,
                                fontSize: 12 * scale,
                                color: const Color(0xFF65DAFF),
                              ),
                            ),
                            SizedBox(height: 22 * scale),
                            _ScannerCard(scale: scale, active: _authenticating),
                            SizedBox(height: 18 * scale),
                            Row(
                              children: [
                                Expanded(
                                  child: _ReadoutBox(
                                    scale: scale,
                                    color: const Color(0xFF65DAFF),
                                    label: 'BIOMETRIC',
                                    value: _available ? 'Ready' : 'Code',
                                  ),
                                ),
                                SizedBox(width: 12 * scale),
                                Expanded(
                                  child: _ReadoutBox(
                                    scale: scale,
                                    color: const Color(0xFFB2C5FF),
                                    label: 'STATUS',
                                    value: _authenticating ? 'Scan' : 'Idle',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18 * scale),
                            SizedBox(
                              height: 56 * scale,
                              child: TextButton(
                                onPressed: _authenticating
                                    ? null
                                    : _authenticate,
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFB2C5FF),
                                  disabledBackgroundColor: const Color(
                                    0xFFB2C5FF,
                                  ).withValues(alpha: 0.45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12 * scale,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  _available
                                      ? 'Register Face'
                                      : 'Continue with Code',
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
            );
          },
        ),
      ),
    );
  }
}

class _ScannerCard extends StatelessWidget {
  const _ScannerCard({required this.scale, required this.active});

  final double scale;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF161B24),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(
          color: const Color.fromRGBO(66, 70, 85, 0.3),
          width: 2,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220 * scale,
              height: 220 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFECF0FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                Icons.person,
                size: 96 * scale,
                color: const Color(0xFFB2C5FF).withValues(alpha: 0.6),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              top: active ? 150 * scale : 70 * scale,
              child: Container(
                height: 6 * scale,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(101, 218, 255, 0),
                      Color(0xFF65DAFF),
                      Color.fromRGBO(101, 218, 255, 0),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFF65DAFF), blurRadius: 20),
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.text,
    required this.color,
    required this.scale,
  });

  final String text;
  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12 * scale,
        vertical: 6 * scale,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'JetBrains Mono',
          fontWeight: FontWeight.w700,
          fontSize: 11 * scale,
        ),
      ),
    );
  }
}

class _ReadoutBox extends StatelessWidget {
  const _ReadoutBox({
    required this.scale,
    required this.color,
    required this.label,
    required this.value,
  });

  final double scale;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(22, 27, 34, 0.6),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: const Color.fromRGBO(66, 70, 85, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontWeight: FontWeight.w500,
              fontSize: 11 * scale,
              color: const Color(0xFFC2C6D8),
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
            ),
          ),
        ],
      ),
    );
  }
}
