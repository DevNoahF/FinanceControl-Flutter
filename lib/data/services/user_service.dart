import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/models/Usuario.dart';

class UserService {
  final ApiClient _client;

  const UserService(this._client);

  Future<List<Usuario>> getUsers() async {
    final data = await _client.get('/usuarios');
    if (data is! List) {
      throw const FormatException('Invalid users response format');
    }
    return data
        .map((item) => Usuario.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Usuario> getUserById(int id) async {
    final data = await _client.get('/usuarios/$id');
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid user response format');
    }
    return Usuario.fromJson(data);
  }

  Future<Usuario> createUser(Usuario usuario) async {
    final data = await _client.post('/usuarios', usuario.toJson());
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid user response format');
    }
    return Usuario.fromJson(data);
  }
}
