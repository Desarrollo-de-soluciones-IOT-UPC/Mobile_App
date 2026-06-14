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
}
