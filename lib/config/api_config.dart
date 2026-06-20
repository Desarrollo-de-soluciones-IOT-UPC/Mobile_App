import 'package:flutter/foundation.dart';

/// Base URL for the EMSafe backend.
///
/// Resolución automática:
///  - Build de DEBUG (flutter run / emulador)  -> backend local
///  - Build de RELEASE (APK / Play Store / prod) -> backend en Azure
///
/// Override manual (sin tocar este archivo), útil para probar en un
/// CELULAR FÍSICO contra tu PC en la misma red WiFi:
///   flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8080/api
///
/// Notas de entorno local:
///  - Emulador Android: `localhost` apunta al emulador, no a tu PC.
///    La PC se alcanza en 10.0.2.2, por eso el dev URL usa esa IP.
///  - Celular físico: usá la IP LAN de tu PC (ej. 192.168.1.50) vía --dart-define.
class ApiConfig {
  /// Override opcional por línea de compilación (--dart-define=API_BASE_URL=...).
  /// Si se define, tiene prioridad sobre dev/prod.
  static const String _override = String.fromEnvironment('API_BASE_URL');

  /// Backend local (emulador Android + backend corriendo en IntelliJ).
  static const String _devUrl = 'http://10.0.2.2:8080/api';

  /// Backend de producción (Azure App Service).
  static const String _prodUrl =
      'https://emsafe-backend-hmf7asgja0d0h4cr.centralus-01.azurewebsites.net/api';

  /// URL efectiva que usa el ApiClient.
  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    return kReleaseMode ? _prodUrl : _devUrl;
  }
}
