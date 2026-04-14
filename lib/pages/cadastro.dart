import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(child: Image.asset("assets/Fundo.jpeg")),
            ),
          ),
        ],
      ),
    );
  }
}
