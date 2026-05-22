import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'finance_control.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    final currentDatabase = _database;
    if (currentDatabase != null) {
      return currentDatabase;
    }

    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = p.join(databasesPath, _databaseName);

    return openDatabase(
      dbPath,
      version: _databaseVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.transaction((txn) async {
          await txn.execute('''
            CREATE TABLE usuarios (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT NOT NULL,
              sobrenome TEXT NOT NULL,
              email TEXT NOT NULL UNIQUE,
              senha_hash TEXT NOT NULL,
              profissao TEXT NOT NULL DEFAULT '',
              idade INTEGER NOT NULL,
              role TEXT NOT NULL DEFAULT 'user',
              created_at TEXT NOT NULL,
              updated_at TEXT,
              sincronizado INTEGER NOT NULL DEFAULT 0
            )
          ''');

          await txn.execute('''
            CREATE TABLE admin (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              email TEXT NOT NULL UNIQUE,
              senha_hash TEXT NOT NULL,
              role TEXT NOT NULL DEFAULT 'adm',
              sincronizado INTEGER NOT NULL DEFAULT 0
            )
          ''');

          await txn.execute('''
            CREATE TABLE transacoes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              user_id INTEGER NOT NULL,
              titulo TEXT NOT NULL,
              descricao TEXT NOT NULL,
              data TEXT NOT NULL,
              tipo TEXT NOT NULL,
              valor REAL NOT NULL,
              sincronizado INTEGER NOT NULL DEFAULT 0,
              FOREIGN KEY (user_id) REFERENCES usuarios(id) ON DELETE CASCADE
            )
          ''');

          await txn.execute(
            'CREATE INDEX idx_usuarios_email ON usuarios(email)',
          );
          await txn.execute(
            'CREATE INDEX idx_usuarios_role ON usuarios(role)',
          );
          await txn.execute(
            'CREATE INDEX idx_admin_email ON admin(email)',
          );
          await txn.execute(
            'CREATE INDEX idx_transacoes_user_id ON transacoes(user_id)',
          );
          await txn.execute(
            'CREATE INDEX idx_transacoes_tipo ON transacoes(tipo)',
          );
          await txn.execute(
            'CREATE INDEX idx_transacoes_data ON transacoes(data)',
          );
        });
      },
    );
  }

  Future<void> close() async {
    final currentDatabase = _database;
    if (currentDatabase != null) {
      await currentDatabase.close();
      _database = null;
    }
  }
}