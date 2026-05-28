import 'package:finance_control/data/database/app_database.dart';
import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/config/api_config.dart';
import 'package:finance_control/data/mappers/admin_mapper.dart';
import 'package:finance_control/data/mappers/transacao_mapper.dart';
import 'package:finance_control/data/mappers/usuario_mapper.dart';
import 'package:finance_control/data/repositories/admin_api_repository.dart';
import 'package:finance_control/data/repositories/transacao_api_repository.dart';
import 'package:finance_control/data/repositories/user_api_repository.dart';
import 'package:finance_control/data/services/admin_service.dart';
import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/data/services/transacao_service.dart';
import 'package:finance_control/data/services/user_service.dart';
import 'package:finance_control/data/repositories/sqlite_admin_repository.dart';
import 'package:finance_control/data/repositories/sqlite_transacao_repository.dart';
import 'package:finance_control/data/repositories/sqlite_usuario_repository.dart';
import 'package:finance_control/data/session/api_session.dart';
import 'package:finance_control/domain/repositories/admin_repository.dart';
import 'package:finance_control/domain/repositories/transacao_repository.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppDatabase>()) {
    return;
  }

  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<AppDatabase>(AppDatabase.instance);
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<CacheService>(CacheService(prefs));
  getIt.registerSingleton<ApiSession>(ApiSession(prefs));
  getIt.registerSingleton<UsuarioMapper>(const UsuarioMapper());
  getIt.registerSingleton<TransacaoMapper>(const TransacaoMapper());
  getIt.registerSingleton<AdminMapper>(const AdminMapper());

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: ApiConfig.baseUrl,
      tokenProvider: () => getIt<ApiSession>().token,
      onUnauthorized: () => getIt<ApiSession>().clear(),
    ),
  );

  getIt.registerLazySingleton<UserService>(
    () => UserService(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<TransacaoService>(
    () => TransacaoService(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AdminService>(
    () => AdminService(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<UserApiRepository>(
    () => UserApiRepository(
      service: getIt<UserService>(),
      cache: getIt<CacheService>(),
    ),
  );

  getIt.registerLazySingleton<TransacaoApiRepository>(
    () => TransacaoApiRepository(
      service: getIt<TransacaoService>(),
      cache: getIt<CacheService>(),
    ),
  );

  getIt.registerLazySingleton<AdminApiRepository>(
    () => AdminApiRepository(
      service: getIt<AdminService>(),
      cache: getIt<CacheService>(),
    ),
  );

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