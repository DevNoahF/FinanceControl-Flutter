import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/usuario_mapper.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';

class SqliteUsuarioRepository implements IUsuarioRepository {
  final AppDatabase database;
  final UsuarioMapper mapper;

  SqliteUsuarioRepository({
    required this.database,
    required this.mapper,
  });
}