import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/core/router/app_router.dart';
import 'package:finance_control/features/auth/cadastroNotifier.dart';
import 'package:finance_control/notifiers/admin_notifier.dart';
import 'package:finance_control/notifiers/transacao_api_notifier.dart';
import 'package:finance_control/notifiers/transacao_notifier.dart';
import 'package:finance_control/notifiers/user_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  bool _initializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      if (kIsWeb) {
        databaseFactory = createDatabaseFactoryFfiWeb(noWebWorker: true);
      } else if (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        databaseFactory = databaseFactoryFfi;
      }

      await configureDependencies();
      await authService.ensureSeed();

      if (!mounted) return;
      setState(() {
        _initializing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _initializing = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Falha ao inicializar a aplicação',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroNotifier()),
        ChangeNotifierProvider(create: (_) => TransacaoNotifier()),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => AdminNotifier()),
        ChangeNotifierProvider(create: (_) => TransacaoApiNotifier()),
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
