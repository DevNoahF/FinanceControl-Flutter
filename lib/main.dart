import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/core/router/app_router.dart';
import 'package:finance_control/features/auth/cadastroNotifier.dart';
import 'package:finance_control/notifiers/transacao_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = createDatabaseFactoryFfiWeb(
      noWebWorker: true,
      options: SqfliteFfiWebOptions(
        indexedDbName: 'finance_control',
        sqlite3WasmUri: Uri.parse(
          'https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-3.1.2/sqlite3.wasm',
        ),
      ),
    );
  } else if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    databaseFactory = databaseFactoryFfi;
  }
  configureDependencies();
  await authService.ensureSeed();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroNotifier()),
        ChangeNotifierProvider(create: (_) => TransacaoNotifier()),
      ],
      child: MaterialApp.router(
        title: 'Finanças',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE0E0E0)),
        routerConfig: appRouter,
      ),
    );
  }
}
