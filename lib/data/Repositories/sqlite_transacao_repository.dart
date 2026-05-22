import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/transacao_mapper.dart';
import 'package:finance_control/domain/repositories/transacao_repository.dart';

class SqliteTransacaoRepository implements ITransacaoRepository {
  final AppDatabase database;
  final TransacaoMapper mapper;

  SqliteTransacaoRepository({
    required this.database,
    required this.mapper,
  });
}