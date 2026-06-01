import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_page_solid.dart';

class PairYourSensorScreen extends StatefulWidget {
  const PairYourSensorScreen({super.key});

  @override
  State<PairYourSensorScreen> createState() => _PairYourSensorScreenState();
}

class _PairYourSensorScreenState extends State<PairYourSensorScreen>
    with TickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageSolid(
      background: AppTheme.darkNavy,
      isDark: true,
      icon: Icons.radar,
      title: 'Escaneando Sensores',
      description: 'Buscando dispositivos disponibles en la red...',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación de escaneo
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Círculo de fondo
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                  ),
                  // Círculo animado
                  RotationTransition(
                    turns: _scanController,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.primaryBlue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // Icono del centro
                  Icon(
                    Icons.sensors,
                    size: 50,
                    color: AppTheme.primaryBlue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Sensores encontrados (simulado)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.darkBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sensores Encontrados:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSensorItem('Sensor Temperatura #001', Icons.thermostat),
                  const SizedBox(height: 8),
                  _buildSensorItem('Sensor Movimiento #002', Icons.motion_photos_on),
                  const SizedBox(height: 8),
                  _buildSensorItem('Sensor Puerta #003', Icons.door_sliding),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.onboardingFinalStep);
                },
                child: const Text('Continuar'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorItem(String name, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryBlue.withValues(alpha: 0.2),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Conectado',
                style: TextStyle(
                  color: AppTheme.successGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.check_circle,
          color: AppTheme.successGreen,
          size: 20,
        ),
      ],
    );
  }
}

