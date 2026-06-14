/// Base URL for the EMSafe backend.
///
/// IMPORTANT (Android emulator): the emulator's `localhost` points to the
/// emulator itself, NOT your PC. The host machine is reachable at 10.0.2.2,
/// so the local backend (http://localhost:8080) is http://10.0.2.2:8080 here.
///
/// - Android emulator (default): http://10.0.2.2:8080/api
/// - Physical device on same Wi-Fi: replace with your PC LAN IP, e.g. http://192.168.1.50:8080/api
/// - Production (Azure): https://emsafe-backend-hmf7asgja0d0h4cr.centralus-01.azurewebsites.net/api
class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
}
