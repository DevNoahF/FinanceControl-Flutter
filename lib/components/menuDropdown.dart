import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_control/core/auth/auth_service.dart';

class MenuDropdown extends StatelessWidget {
  final String nomeUsuario;

  const MenuDropdown({Key? key, required this.nomeUsuario}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      onSelected: (String value) {
        if (value == 'logout') {
          authService.logout();
          context.go('/login'); 
        } else if (value == 'atualizar') {
          context.go('/emConstrucao');
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'atualizar',
          child: Row(
            children: [
              Icon(Icons.edit, size: 18),
              SizedBox(width: 8),
              Text('Atualizar Dados'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 18, color: Colors.red),
              SizedBox(width: 8),
              Text('Sair', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Olá, $nomeUsuario',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
