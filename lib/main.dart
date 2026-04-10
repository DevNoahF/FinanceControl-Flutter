import 'package:flutter/material.dart';
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
      title: 'Finance Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Cadastro(),
    );
  }
}