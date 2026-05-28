import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/transacao_mapper.dart';
import 'package:finance_control/domain/repositories/transacao_repository.dart';
import 'package:finance_control/models/transacao.dart';
import 'package:sqflite/sqflite.dart';

class SqliteTransacaoRepository implements ITransacaoRepository {
  final AppDatabase database;
  final TransacaoMapper mapper;

  SqliteTransacaoRepository({
    required this.database,
    required this.mapper,
  });

  Future<Database> get _db async => database.database;

  @override
  Future<int> insert(Transacao transacao) async {
    final db = await _db;
    return db.insert('transacoes', mapper.toMap(transacao));
  }

  @override
  Future<List<Transacao>> getAll() async {
    final db = await _db;
    final rows = await db.query('transacoes', orderBy: 'id DESC');
    return rows.map(mapper.fromMap).toList();
  }

  @override
  Future<List<Transacao>> getByUserId(int userId) async {
    final db = await _db;
    final rows = await db.query(
      'transacoes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );
    return rows.map(mapper.fromMap).toList();
  }

  @override
  Future<Transacao?> getById(int id) async {
    final db = await _db;
    final rows = await db.query(
      'transacoes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return mapper.fromMap(rows.first);
  }

  @override
  Future<int> update(Transacao transacao) async {
    final db = await _db;
    return db.update(
      'transacoes',
      mapper.toMap(transacao),
      where: 'id = ?',
      whereArgs: [transacao.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return db.delete('transacoes', where: 'id = ?', whereArgs: [id]);
  }
}