import 'package:flutter/material.dart';
import 'package:finance_control/models/usuario.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  final List<Usuario> _usuarios = [
    Usuario(
      id: 1,
      nome: 'Admin',
      sobrenome: 'Teste',
      email: 'admin@teste.com',
      senha: '123',
      idade: 20,
      created_at: DateTime.now(),
    ),
  ];

  bool get isAuthenticated => _isAuthenticated;

  List<Usuario> get usuarios => _usuarios;

  void cadastrar(Usuario usuario) {
    _usuarios.add(usuario);
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) {
    final usuarioExiste = _usuarios.any(
      (usuario) =>
          usuario.email == email.trim() &&
          usuario.senha == password.trim(),
    );

    if (usuarioExiste) {
      _updateAuth(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário ou senha incorretos"),
        ),
      );
    }
  }

  void logout() {
    _updateAuth(false);
  }

  void _updateAuth(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

final authService = AuthService();