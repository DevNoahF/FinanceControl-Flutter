import 'package:finance_control/models/Usuario.dart';

abstract interface class IUsuarioRepository {
	Future<int> insert(Usuario usuario);
	Future<List<Usuario>> getAll();
	Future<Usuario?> getById(int id);
	Future<Usuario?> getByEmail(String email);
	Future<int> update(Usuario usuario);
	Future<int> delete(int id);
}