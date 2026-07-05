import '../models/client_models.dart';
import 'api_client.dart';
import 'session_store.dart';

/// High-level API for the EMSafe mobile (client) app.
class ClientApi {
  /// Authenticates against the backend and stores the session.
  /// Only CLIENT (and ADMIN, for testing) accounts may use the mobile app.
  static Future<void> login(String email, String password) async {
    final data = await ApiClient.post(
      '/auth/login',
      {'email': email.trim(), 'password': password},
      auth: false,
    ) as Map<String, dynamic>;

    final role = (data['role'] ?? '').toString().toLowerCase();
    if (role != 'client' && role != 'admin') {
      throw ApiException(
        'This account is not a client account. Use the EMSafe web portal instead.',
      );
    }

    await SessionStore.save(
      token: (data['token'] ?? '').toString(),
      name: (data['name'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      role: role,
      userId: (data['userId'] as num).toInt(),
    );
  }

  static Future<ClientProfile> profile() async =>
      ClientProfile.fromJson(await ApiClient.get('/client/profile') as Map<String, dynamic>);

  static Future<ClientDashboard> dashboard() async =>
      ClientDashboard.fromJson(await ApiClient.get('/client/dashboard') as Map<String, dynamic>);

  static Future<List<ClientDevice>> devices() async =>
      ((await ApiClient.get('/client/devices')) as List)
          .map((e) => ClientDevice.fromJson(e as Map<String, dynamic>))
          .toList();

  static Future<List<ClientReading>> deviceReadings(int deviceId) async =>
      ((await ApiClient.get('/client/devices/$deviceId/readings')) as List)
          .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
          .toList();

  static Future<List<ClientAlert>> alerts() async =>
      ((await ApiClient.get('/client/alerts')) as List)
          .map((e) => ClientAlert.fromJson(e as Map<String, dynamic>))
          .toList();

  /// Orders the device relay to open/close the power ("ON" | "OFF").
  /// The edge picks up the order and drives the physical relay.
  static Future<ClientDevice> setPlug(int deviceId, String plug) async =>
      ClientDevice.fromJson(await ApiClient.patch(
        '/client/devices/$deviceId/plug',
        {'plug': plug},
      ) as Map<String, dynamic>);

  /// "Astra" assistant: sends the question (plus recent history) to the
  /// backend, which proxies Gemini — the API key never ships in the app.
  static Future<String> chat(
      String message, List<Map<String, String>> history) async {
    final data = await ApiClient.post('/client/chat', {
      'message': message,
      'history': history,
    }) as Map<String, dynamic>;
    return (data['reply'] ?? '').toString();
  }

  /// Aggregated radiation report: period = "month" | "year".
  static Future<ClientReport> report(String period) async =>
      ClientReport.fromJson(await ApiClient.get('/client/reports?period=$period')
          as Map<String, dynamic>);

  /// All the client's readings (history) — used by the CSV export.
  static Future<List<ClientReading>> readings() async =>
      ((await ApiClient.get('/client/readings')) as List)
          .map((e) => ClientReading.fromJson(e as Map<String, dynamic>))
          .toList();

  static Future<ClientProfile> updateProfile({
    String? name,
    String? phone,
    String? location,
    String? address,
  }) async =>
      ClientProfile.fromJson(await ApiClient.put('/client/profile', {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (location != null) 'location': location,
        if (address != null) 'address': address,
      }) as Map<String, dynamic>);

  static Future<void> changePassword(
      String currentPassword, String newPassword) async {
    await ApiClient.patch('/client/password', {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  /// Permanently deletes the authenticated client's account (GDPR-style).
  /// Requires the current password as confirmation.
  static Future<void> deleteAccount(String password) async {
    await ApiClient.post('/client/account/delete', {'password': password});
    await SessionStore.clear();
  }

  /// Public sign-up: creates a CLIENT account in "pending" state.
  /// The user cannot log in until an admin activates the account.
  static Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    await ApiClient.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (address != null && address.isNotEmpty) 'address': address,
      },
      auth: false,
    );
  }
}
