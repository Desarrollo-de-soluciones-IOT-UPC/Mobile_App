import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../config/api_config.dart';
import 'app_settings_store.dart';
import 'notification_service.dart';

/// STOMP/WebSocket client for live telemetry (same contract as the web:
/// the backend broadcasts every ingested reading to /topic/readings).
///
/// Screens listen to [readingTick] (a counter bumped on every reading) and
/// refresh their data — mirroring the web's debounced re-fetch pattern.
class RealtimeService {
  static StompClient? _client;

  /// Bumped on every reading received; listen + debounce to refresh UI.
  static final ValueNotifier<int> readingTick = ValueNotifier<int>(0);

  /// Raw payload of the last reading received (ReadingDto JSON).
  static Map<String, dynamic>? lastReading;

  static void ensureConnected() {
    if (_client != null) return;
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
  }

  static void disconnect() {
    _client?.deactivate();
    _client = null;
  }

  static void _onConnect(StompFrame frame) {
    debugPrint('[EMSafe][WS] connected to ${ApiConfig.wsUrl}');
    _client?.subscribe(
      destination: '/topic/readings',
      callback: (StompFrame frame) {
        final body = frame.body;
        if (body == null || body.isEmpty) return;
        try {
          final data = jsonDecode(body) as Map<String, dynamic>;
          lastReading = data;
          readingTick.value++;

          // Local notification on DANGER readings (Settings → Push alerts).
          final level = (data['level'] ?? '').toString().toUpperCase();
          if (level == 'DANGER' && AppSettingsStore.pushAlerts) {
            final name =
                (data['deviceName'] ?? data['serialNumber'] ?? 'Sensor')
                    .toString();
            final value = (data['field_uT'] as num?)?.toDouble();
            NotificationService.showDangerAlert(name, value);
          }
        } catch (_) {
          // Ignore malformed frames — next reading will arrive shortly.
        }
      },
    );
  }
}
