# EMSafe — App móvil (Flutter)

App del **cliente final**: ve sus sensores, su exposición en µT, sus alertas e informes,
controla el relé de cada sensor y consulta al asistente "Astra". Consume `/api/client/**`
del backend y recibe telemetría en vivo por STOMP/WebSocket.

> Arquitectura completa del sistema: [`../ARQUITECTURA-EMSAFE.md`](../ARQUITECTURA-EMSAFE.md)

## Estructura

```
lib/
├── core/          api_client · api_config · session_store · app_i18n · app_theme
│                  app_navigator · app_settings_store · notification_service · json
├── contexts/      ◄── espejo de los bounded contexts del backend
│   ├── iam/         domain/user.dart · application/auth_service.dart
│   ├── device/      domain/{device,plug_state}.dart · application/device_service.dart
│   ├── monitoring/  domain/{reading,radiation_level}.dart
│   │                application/monitoring_service.dart
│   │                infrastructure/reading_socket.dart
│   ├── alerting/    domain/alert.dart · application/alert_service.dart
│   ├── reporting/   domain/{report,dashboard_summary}.dart · application/reporting_service.dart
│   └── assistant/   domain/conversation.dart · application/assistant_service.dart
├── presentation/
│   ├── onboarding/  bienvenida y emparejamiento
│   ├── auth/        login, registro, recuperación, verificación
│   └── home/        dashboard · monitor · vitals · alerts · settings
│                    map · reports · astra · widgets/danger_alert_gate.dart
├── routes/         app_routes · auth_routes · home_routes
├── widgets/
└── main.dart
```

**Reglas de dependencia**

- `presentation/` consume los **servicios de aplicación** de cada contexto, nunca
  `ApiClient` directamente.
- `contexts/monitoring/domain/radiation_level.dart` tiene la **misma regla de umbrales**
  que el backend, el edge y la web: `safe < 100 µT`, `caution 100–200`, `danger ≥ 200`.
  El edge es la autoridad; `levelOf()` sólo clasifica por valor si la lectura llega sin
  nivel.
- El relé se ordena con el VO `PlugState`, no con la cadena `'ON'`.
- El socket STOMP es infraestructura: publica `dangerReading` y ya. Quién enseña el
  diálogo de "¿cortamos la corriente?" es
  `presentation/home/widgets/danger_alert_gate.dart`.

## Desarrollo

```bash
flutter pub get
flutter run                 # emulador Android
```

`lib/core/api_config.dart` resuelve la URL sola:

| Modo | URL |
|---|---|
| debug (por defecto) | `http://10.0.2.2:8080/api` — así ve el emulador Android el `localhost` del PC |
| release | `https://emsafe.duckdns.org/api` |
| override | `--dart-define=API_BASE_URL=…` (p. ej. un móvil físico en la misma Wi-Fi) |

La URL del WebSocket se deriva de la anterior (`/api` → `/ws`, `http`→`ws`, `https`→`wss`).

## Build

```bash
flutter analyze             # 4 issues de estilo conocidos, ningún error
flutter build apk --debug
```

> `flutter analyze` **no** compila el árbol entero: construye el APK antes de dar por
> buena cualquier reestructuración.

## Estado

- El emparejamiento BLE de `onboarding/` es visual: los sensores los da de alta un
  técnico desde el portal web.
- Las preferencias de Ajustes se guardan **sólo en local** (`shared_preferences`).
- Las notificaciones son **locales**, sin FCM.
- El chat de Astra necesita `GEMINI_API_KEY` configurada en el backend; si no la hay, la
  app recibe "asistente no configurado" y el resto funciona igual.
- Rama de trabajo: `feature/health-tips-vitals-design`.

## Credenciales de desarrollo

| Email | Password |
|---|---|
| `ops@quantumdyn.com` | `client123` |
| `facilities@harbormed.com` | `client123` |
| `safety@globalpharma.com` | `client123` |
