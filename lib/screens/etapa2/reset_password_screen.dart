import 'dart:ui';

import 'package:flutter/material.dart';

/// Reset Password (Etapa 2)
/// Responsive + compacto: sin artboard rígido y con inputs reales.
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double scale = (size.width / 390).clamp(0.85, 1.15);

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
                              Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28 * scale,
                                  color: const Color(0xFFE1E2EE),
                                ),
                              ),
                              SizedBox(height: 8 * scale),
                              Text(
                                'Enter your email and we’ll send a reset link.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14 * scale,
                                  height: 1.5,
                                  color: const Color(0xFFC2C6D8),
                                ),
                              ),
                              SizedBox(height: 24 * scale),

                              // Input
                              Text(
                                'Registered Email Address',
                                style: TextStyle(
                                  fontFamily: 'JetBrains Mono',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11 * scale,
                                  color: const Color(0xFFC2C6D8),
                                ),
                              ),
                              SizedBox(height: 8 * scale),

                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'name@medical-node.com',
                                  filled: true,
                                  fillColor: const Color(0xFF0B0E16),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16 * scale,
                                    vertical: 16 * scale,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.mail_outline,
                                    color: const Color(0xFF8C90A1),
                                    size: 20 * scale,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6 * scale),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(66, 70, 85, 0.5),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6 * scale),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF5B8CFF),
                                      width: 1.2,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF8C90A1),
                                    fontSize: 14 * scale,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10 * scale),
                              Text(
                                'We’ll send a reset link to your inbox.',
                                style: TextStyle(
                                  fontFamily: 'JetBrains Mono',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11 * scale,
                                  height: 1.4,
                                  color: const Color(0xFF8C90A1),
                                ),
                              ),

                              SizedBox(height: 20 * scale),

                              SizedBox(
                                width: double.infinity,
                                height: 56 * scale,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        '/etapa2/verification-success');
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
                                    'Send',
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16 * scale,
                                      color: const Color(0xFF002565),
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
              ),
            );
          },
        ),
      ),
    );
  }
}

