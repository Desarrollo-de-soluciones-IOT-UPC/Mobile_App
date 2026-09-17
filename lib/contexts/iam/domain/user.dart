import '../../../core/json.dart';
/// Perfil del cliente autenticado.
class ClientProfile {
  ClientProfile({
    required this.id,
    required this.name,
    required this.initials,
    required this.email,
    required this.role,
    this.phone,
    this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.joinDate,
  });

  final int id;
  final String name;
  final String? initials;
  final String email;
  final String role;
  final String? phone;
  final String? location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? joinDate;

  factory ClientProfile.fromJson(Map<String, dynamic> j) => ClientProfile(
        id: toIntOrZero(j['id']),
        name: toStr(j['name']),
        initials: j['initials']?.toString(),
        email: toStr(j['email']),
        role: toStr(j['role']),
        phone: j['phone']?.toString(),
        location: j['location']?.toString(),
        address: j['address']?.toString(),
        latitude: toDoubleOrNull(j['latitude']),
        longitude: toDoubleOrNull(j['longitude']),
        joinDate: j['joinDate']?.toString(),
      );
}
