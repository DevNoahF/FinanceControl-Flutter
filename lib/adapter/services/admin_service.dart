import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/data/models/admin.dart';

class AdminService {
  final ApiClient _client;

  const AdminService(this._client);

  Future<List<Admin>> getAdmins() async {
    final data = await _client.get('/admins');
    if (data is! List) {
      throw const FormatException('Invalid admins response format');
    }
    return data
        .map((item) => Admin.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Admin?> getAdminByEmail(String email) async {
    final data = await _client.get(
      '/admins',
      queryParameters: {'email': email.trim()},
    );
    if (data is! List) {
      throw const FormatException('Invalid admin response format');
    }
    if (data.isEmpty) return null;
    return Admin.fromJson(data.first as Map<String, dynamic>);
  }

  Future<Admin> createAdmin(Admin admin) async {
    final data = await _client.post('/admins', admin.toJson());
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid admin response format');
    }
    return Admin.fromJson(data);
  }
}
