import 'package:flutter/material.dart';

import 'pages/dashboard.dart';
import 'pages/cadastro.dart';
import 'pages/cadastro.dart'; // importa o arquivo da sua tela
import 'pages/login.dart'; // importa o arquivo da sua tela


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanças',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE0E0E0)),
      home: const HomeScreen(),
      routes: {
        '/dashboard': (context) => const HomeScreen(),
        '/cadastro': (context) => Cadastro(),
      },
      title: 'Finance Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Cadastro(),
    );
  }
}
