import 'package:flutter/material.dart';
import 'package:finance_control/core/router/app_router.dart';
import 'package:finance_control/features/auth/cadastroNotifier.dart';
import 'package:finance_control/notifiers/transacao_notifier.dart';
import 'package:provider/provider.dart';


void main() {
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
