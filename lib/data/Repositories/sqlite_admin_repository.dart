import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/admin_mapper.dart';
import 'package:finance_control/domain/repositories/admin_repository.dart';

class SqliteAdminRepository implements IAdminRepository {
  final AppDatabase database;
  final AdminMapper mapper;

  SqliteAdminRepository({
    required this.database,
    required this.mapper,
  });
}