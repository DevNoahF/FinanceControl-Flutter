import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/usuario_mapper.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:finance_control/models/Usuario.dart';
import 'package:sqflite/sqflite.dart';

class SqliteUsuarioRepository implements IUsuarioRepository {
  final AppDatabase database;
  final UsuarioMapper mapper;

  SqliteUsuarioRepository({
    required this.database,
    required this.mapper,
  });

  Future<Database> get _db async => database.database;

  @override
  Future<int> insert(Usuario usuario) async {
    final db = await _db;
    return db.insert('usuarios', mapper.toMap(usuario));
  }

  @override
  Future<List<Usuario>> getAll() async {
    final db = await _db;
    final rows = await db.query('usuarios', orderBy: 'id DESC');
    return rows.map(mapper.fromMap).toList();
  }

  @override
  Future<Usuario?> getById(int id) async {
    final db = await _db;
    final rows = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return mapper.fromMap(rows.first);
  }

  @override
  Future<Usuario?> getByEmail(String email) async {
    final db = await _db;
    final rows = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email.trim()],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return mapper.fromMap(rows.first);
  }

  @override
  Future<int> update(Usuario usuario) async {
    final db = await _db;
    return db.update(
      'usuarios',
      mapper.toMap(usuario),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}