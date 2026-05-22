import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:finance_control/models/Usuario.dart';

class MemoryUsuarioRepository implements IUsuarioRepository {
  final List<Usuario> _usuarios = [];

  int get _nextId {
    if (_usuarios.isEmpty) return 1;
    return _usuarios.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  @override
  Future<int> insert(Usuario usuario) async {
    final nextId = usuario.id == 0 ? _nextId : usuario.id;
    _usuarios.add(usuario.copyWith(id: nextId));
    return nextId;
  }

  @override
  Future<List<Usuario>> getAll() async => List.unmodifiable(_usuarios);

  @override
  Future<Usuario?> getById(int id) async {
    try {
      return _usuarios.firstWhere((usuario) => usuario.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Usuario?> getByEmail(String email) async {
    try {
      return _usuarios.firstWhere((usuario) => usuario.email == email.trim());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> update(Usuario usuario) async {
    final index = _usuarios.indexWhere((item) => item.id == usuario.id);
    if (index == -1) return 0;
    _usuarios[index] = usuario;
    return 1;
  }

  @override
  Future<int> delete(int id) async {
    final before = _usuarios.length;
    _usuarios.removeWhere((usuario) => usuario.id == id);
    return before - _usuarios.length;
  }
}