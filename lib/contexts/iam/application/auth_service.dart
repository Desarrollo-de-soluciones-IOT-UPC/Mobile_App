import '../../../core/api_client.dart';
import '../../../core/session_store.dart';
import '../domain/user.dart';
/// Cuenta del cliente: entrar, registrarse, editar el perfil y darse de baja.
///
/// Es una de las seis piezas en las que se partió `ClientApi`, que concentraba los
/// endpoints de todos los contextos en un solo archivo estático.
class AuthService {
  /// Autentica contra el backend y guarda la sesión.
  /// Sólo cuentas CLIENT (y ADMIN, para pruebas) pueden usar la app móvil.
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

  /// Registro público: crea una cuenta CLIENT en estado "pending".
  /// No se puede entrar hasta que un administrador la active.
  static Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
    String? clientType,
    String? contactName,
    String? taxId,
    String? industry,
  }) async {
    await ApiClient.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (address != null && address.isNotEmpty) 'address': address,
        if (clientType != null && clientType.isNotEmpty) 'clientType': clientType,
        if (contactName != null && contactName.isNotEmpty) 'contactName': contactName,
        if (taxId != null && taxId.isNotEmpty) 'taxId': taxId,
        if (industry != null && industry.isNotEmpty) 'industry': industry,
      },
      auth: false,
    );
  }

  static Future<ClientProfile> profile() async => ClientProfile.fromJson(
      await ApiClient.get('/client/profile') as Map<String, dynamic>);

  static Future<ClientProfile> updateProfile({
    String? name,
    String? phone,
    String? location,
    String? address,
  }) async =>
      ClientProfile.fromJson(await ApiClient.put('/client/profile', {
        'name': ?name,
        'phone': ?phone,
        'location': ?location,
        'address': ?address,
      }) as Map<String, dynamic>);

  static Future<void> changePassword(
      String currentPassword, String newPassword) async {
    await ApiClient.patch('/client/password', {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  /// Baja voluntaria de la cuenta (derecho al olvido), confirmada con la contraseña.
  static Future<void> deleteAccount(String password) async {
    await ApiClient.post('/client/account/delete', {'password': password});
    await SessionStore.clear();
  }
}
