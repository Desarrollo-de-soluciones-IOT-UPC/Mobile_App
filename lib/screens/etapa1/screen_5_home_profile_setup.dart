import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class HomeProfileSetupScreen extends StatefulWidget {
  const HomeProfileSetupScreen({super.key});

  @override
  State<HomeProfileSetupScreen> createState() => _HomeProfileSetupScreenState();
}

class _HomeProfileSetupScreenState extends State<HomeProfileSetupScreen> {
  late TextEditingController _homeName;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _homeName = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _homeName.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isValid => _homeName.text.trim().isNotEmpty;

  void _saveProfile() {
    if (_isValid) {
      Navigator.of(context).pushNamed(AppRoutes.pairingSensors);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.home_outlined,
      title: 'Configurar tu Hogar',
      description: 'Dale un nombre único a tu espacio protegido',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: _homeName,
              builder: (context, child) {
                return Column(
                  children: [
                    TextField(
                      controller: _homeName,
                      focusNode: _focusNode,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ej: Casa Principal, Apartamento',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: AppTheme.darkBg,
                        prefixIcon: Icon(
                          Icons.home,
                          color: AppTheme.primaryCyan,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                          color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppTheme.primaryCyan,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                      ),
                      onSubmitted: (_) => _saveProfile(),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _isValid ? _saveProfile : null,
                        child: const Text('Guardar'),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

