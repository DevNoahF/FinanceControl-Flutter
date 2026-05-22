import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/admin_mapper.dart';
import 'package:finance_control/domain/repositories/admin_repository.dart';
import 'package:finance_control/models/admin.dart';
import 'package:sqflite/sqflite.dart';

class SqliteAdminRepository implements IAdminRepository {
  final AppDatabase database;
  final AdminMapper mapper;

  SqliteAdminRepository({
    required this.database,
    required this.mapper,
  });

  Future<Database> get _db async => database.database;

  @override
  Future<int> insert(Admin admin) async {
    final db = await _db;
    return db.insert('admin', mapper.toMap(admin));
  }

  @override
  Future<List<Admin>> getAll() async {
    final db = await _db;
    final rows = await db.query('admin', orderBy: 'id DESC');
    return rows.map(mapper.fromMap).toList();
  }

  @override
  Future<Admin?> getById(int id) async {
    final db = await _db;
    final rows = await db.query(
      'admin',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return mapper.fromMap(rows.first);
  }

  @override
  Future<Admin?> getByEmail(String email) async {
    final db = await _db;
    final rows = await db.query(
      'admin',
      where: 'email = ?',
      whereArgs: [email.trim()],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return mapper.fromMap(rows.first);
  }

  @override
  Future<int> update(Admin admin) async {
    final db = await _db;
    return db.update(
      'admin',
      mapper.toMap(admin),
      where: 'email = ?',
      whereArgs: [admin.email],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return db.delete('admin', where: 'id = ?', whereArgs: [id]);
  }
}