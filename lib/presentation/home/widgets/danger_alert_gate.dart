import 'package:flutter/material.dart';

import '../../../contexts/device/application/device_service.dart';
import '../../../contexts/device/domain/plug_state.dart';
import '../../../contexts/monitoring/domain/radiation_level.dart';
import '../../../contexts/monitoring/infrastructure/reading_socket.dart';
import '../../../core/api_client.dart';
import '../../../core/app_i18n.dart';
import '../../../core/app_navigator.dart';
import '../home_components.dart';
/// Monta un escucha global que, ante una lectura DANGER de un sensor propio del
/// cliente, pregunta si cortar la corriente y —si se confirma— manda la orden de
/// relé OFF (backend → edge → dispositivo). Usa [appNavigatorKey] para que el
/// diálogo salga esté donde esté el usuario.
///
/// Vivía dentro de `realtime_service.dart`, es decir, un widget dentro de un
/// archivo de infraestructura. Ahora el socket sólo publica el hecho y la decisión
/// de cómo mostrarlo es de la capa de presentación.
class DangerAlertGate extends StatefulWidget {
  const DangerAlertGate({super.key, required this.child});

  final Widget child;

  @override
  State<DangerAlertGate> createState() => _DangerAlertGateState();
}

class _DangerAlertGateState extends State<DangerAlertGate> {
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    ReadingSocket.dangerReading.addListener(_onDanger);
  }

  @override
  void dispose() {
    ReadingSocket.dangerReading.removeListener(_onDanger);
    super.dispose();
  }

  Future<void> _onDanger() async {
    final data = ReadingSocket.dangerReading.value;
    if (data == null || _dialogOpen) return;
    final ctx = appNavigatorKey.currentContext;
    if (ctx == null) return;

    final deviceId = (data['deviceDbId'] as num?)?.toInt();
    if (deviceId == null) return;
    final name =
        (data['deviceName'] ?? data['serialNumber'] ?? 'Sensor').toString();
    final value = (data['field_uT'] as num?)?.toDouble();

    _dialogOpen = true;
    final cut = await showDialog<bool>(
      context: ctx,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (dialogCtx) => _DangerDialog(name: name, value: value),
    );
    _dialogOpen = false;

    if (cut == true) {
      try {
        await DeviceService.setPlug(deviceId, PlugState.off);
        ReadingSocket.readingTick.value++; // empuja a las pantallas a refrescar
      } on ApiException catch (e) {
        final messenger = appNavigatorKey.currentContext;
        if (messenger != null && messenger.mounted) {
          ScaffoldMessenger.of(messenger)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Diálogo DANGER (tema oscuro, acento rojo) que ofrece cortar la corriente.
/// Devuelve `true` (cortar) o `false` (dejar encendido).
class _DangerDialog extends StatelessWidget {
  const _DangerDialog({required this.name, this.value});

  final String name;
  final double? value;

  @override
  Widget build(BuildContext context) {
    const red = HomePalette.red;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        decoration: BoxDecoration(
          color: HomePalette.panel,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: red.withValues(alpha: 0.45)),
          boxShadow: [
            BoxShadow(
              color: red.withValues(alpha: 0.22),
              blurRadius: 40,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: red.withValues(alpha: 0.14),
                border: Border.all(color: red.withValues(alpha: 0.5), width: 1.5),
              ),
              child: const Icon(Icons.warning_amber_rounded,
                  color: red, size: 34),
            ),
            const SizedBox(height: 18),
            Text(
              tr('danger_modalTitle'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: HomePalette.text,
                fontSize: 19,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: red.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: HomePalette.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${value?.toStringAsFixed(1) ?? '--'} $radiationUnit',
                    style: const TextStyle(
                      color: red,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              tr('danger_modalBody'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: HomePalette.muted,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      foregroundColor: HomePalette.muted,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: HomePalette.stroke),
                      ),
                    ),
                    child: Text(
                      tr('danger_keepOn'),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      backgroundColor: red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Text(tr('danger_cutPower')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
