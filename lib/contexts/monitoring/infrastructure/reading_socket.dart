import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../../core/api_config.dart';
import '../../../core/app_settings_store.dart';
import '../../../core/notification_service.dart';
import '../../../core/session_store.dart';
import '../domain/radiation_level.dart';

/// Cliente STOMP/WebSocket de telemetría en vivo.
///
/// El backend difunde cada lectura al topic global `/topic/readings` (para la web
/// de admin y técnico) y, cuando el sensor tiene dueño, a
/// `/topic/clients/{clientId}/readings`. La app se suscribe SÓLO a su propio topic,
/// así que un cliente nunca ve —ni recibe alertas DANGER de— sensores ajenos.
///
/// Las pantallas escuchan [readingTick] (un contador que sube con cada lectura) y
/// refrescan. Ante DANGER se publica [dangerReading] para que la app ofrezca cortar
/// la corriente (lo hace `DangerAlertGate`, en la capa de presentación).
///
/// **Antes esto era `RealtimeService`** y vivía en `lib/services/` junto con los dos
/// widgets del diálogo de peligro: un archivo de infraestructura que importaba la
/// paleta de colores de las pantallas. Al separarlos, el socket dejó de conocer
/// Material, la paleta y la API de dispositivos.
class ReadingSocket {
  static StompClient? _client;
  static int? _userId;

  /// Sube con cada lectura recibida; escuchar + hacer debounce para refrescar.
  static final ValueNotifier<int> readingTick = ValueNotifier<int>(0);

  /// Payload crudo de la última lectura recibida (JSON de `ReadingDto`).
  static Map<String, dynamic>? lastReading;

  /// Payload de la última lectura DANGER de un sensor PROPIO del cliente. Se
  /// publica una vez por episodio y por dispositivo (ver [_dangerHandled]).
  static final ValueNotifier<Map<String, dynamic>?> dangerReading =
      ValueNotifier<Map<String, dynamic>?>(null);

  /// Dispositivos con un episodio DANGER ya atendido — evita repetir el modal en
  /// cada lectura mientras el nivel siga en DANGER. Se limpia cuando ese mismo
  /// dispositivo reporta una lectura que ya no es peligrosa.
  static final Set<int> _dangerHandled = <int>{};

  /// Evita tumbar un cliente que aún está en su handshake inicial (el panel y el
  /// monitor llaman a esto los dos en su init).
  static bool _activating = false;

  static Future<void> ensureConnected() async {
    final existing = _client;
    if (existing != null) {
      // Reutiliza una conexión viva. Si el auto-reconnect de stomp se rinde
      // (p. ej. reiniciaron el backend), el cliente queda desconectado: se tira
      // y se crea uno nuevo para volver a suscribirse siempre.
      if (existing.connected || _activating) return;
      existing.deactivate();
      _client = null;
    }
    if (_activating) return;
    _activating = true;
    try {
      _userId = await SessionStore.userId();
      final client = StompClient(
        config: StompConfig(
          url: ApiConfig.wsUrl,
          reconnectDelay: const Duration(seconds: 5),
          onConnect: _onConnect,
          onWebSocketError: (dynamic error) =>
              debugPrint('[EMSafe][WS] error: $error'),
        ),
      );
      _client = client;
      client.activate();
    } finally {
      _activating = false;
    }
  }

  static void disconnect() {
    _client?.deactivate();
    _client = null;
    _dangerHandled.clear();
  }

  static void _onConnect(StompFrame frame) {
    // Sólo las lecturas propias. Si no se conoce el id de usuario (no debería
    // pasar con sesión iniciada) cae al topic global y filtra por clientId.
    final destination = _userId != null
        ? '/topic/clients/$_userId/readings'
        : '/topic/readings';
    debugPrint('[EMSafe][WS] connected → $destination');
    _client?.subscribe(
      destination: destination,
      callback: (StompFrame frame) {
        final body = frame.body;
        if (body == null || body.isEmpty) return;
        try {
          final data = jsonDecode(body) as Map<String, dynamic>;
          // Filtro defensivo (sólo relevante en el topic global de respaldo).
          if (_userId != null &&
              data['clientId'] != null &&
              (data['clientId'] as num).toInt() != _userId) {
            return;
          }
          lastReading = data;
          readingTick.value++;
          _handleLevel(data);
        } catch (_) {
          // Trama malformada: se ignora, la siguiente lectura llega enseguida.
        }
      },
    );
  }

  static void _handleLevel(Map<String, dynamic> data) {
    final value = (data['field_uT'] as num?)?.toDouble();
    // El nivel lo decide el edge; `levelOf` sólo clasifica si no viniera.
    final level = levelOf(data['level']?.toString(), value);
    final deviceId = (data['deviceDbId'] as num?)?.toInt();

    if (!level.isDangerous) {
      // Se acabó el episodio de este dispositivo: se permite volver a avisar.
      if (deviceId != null) _dangerHandled.remove(deviceId);
      return;
    }

    // Notificación local (Ajustes → Alertas push).
    if (AppSettingsStore.pushAlerts) {
      final name =
          (data['deviceName'] ?? data['serialNumber'] ?? 'Sensor').toString();
      NotificationService.showDangerAlert(name, value);
    }

    // Ofrecer cortar la corriente: una vez por episodio y dispositivo, y sólo si
    // sigue habiendo corriente. Si el relé ya reporta OFF (lo cortó el usuario o
    // el fail-safe local del equipo) no hay nada que cortar y no se muestra el
    // modal. En ese caso NO se marca el episodio como atendido, para volver a
    // preguntar si la corriente regresa mientras sigue en DANGER.
    final plugOff = (data['plug'] ?? '').toString().toUpperCase() == 'OFF';
    if (deviceId == null || plugOff || _dangerHandled.contains(deviceId)) return;
    _dangerHandled.add(deviceId);
    dangerReading.value = data;
  }
}
