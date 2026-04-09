import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(
            color: Colors.white,
            child: Center(child: Image.asset("assets/download.jpg"),),
          ))
        ],
      ),
    );
  }
}