import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/mappers/admin_mapper.dart';
import 'package:finance_control/data/mappers/transacao_mapper.dart';
import 'package:finance_control/data/mappers/usuario_mapper.dart';
import 'package:finance_control/data/repositories/sqlite_admin_repository.dart';
import 'package:finance_control/data/repositories/sqlite_transacao_repository.dart';
import 'package:finance_control/data/repositories/sqlite_usuario_repository.dart';
import 'package:finance_control/domain/repositories/admin_repository.dart';
import 'package:finance_control/domain/repositories/transacao_repository.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  if (getIt.isRegistered<AppDatabase>()) {
    return;
  }

  getIt.registerSingleton<AppDatabase>(AppDatabase.instance);
  getIt.registerSingleton<UsuarioMapper>(const UsuarioMapper());
  getIt.registerSingleton<TransacaoMapper>(const TransacaoMapper());
  getIt.registerSingleton<AdminMapper>(const AdminMapper());

  getIt.registerLazySingleton<IUsuarioRepository>(
    () => SqliteUsuarioRepository(
      database: getIt<AppDatabase>(),
      mapper: getIt<UsuarioMapper>(),
    ),
  );

  getIt.registerLazySingleton<ITransacaoRepository>(
    () => SqliteTransacaoRepository(
      database: getIt<AppDatabase>(),
      mapper: getIt<TransacaoMapper>(),
    ),
  );

  getIt.registerLazySingleton<IAdminRepository>(
    () => SqliteAdminRepository(
      database: getIt<AppDatabase>(),
      mapper: getIt<AdminMapper>(),
    ),
  );
}