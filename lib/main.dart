import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'pages/dashboard.dart';
=======
import 'pages/cadastro.dart'; // importa o arquivo da sua tela
>>>>>>> 62006ff9dfa2d8b904045f965ee444d09e4c2853

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Finanças',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE0E0E0)),
      home: const HomeScreen(),
=======
      title: 'Finance Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Cadastro(), 
>>>>>>> 62006ff9dfa2d8b904045f965ee444d09e4c2853
    );
  }
}