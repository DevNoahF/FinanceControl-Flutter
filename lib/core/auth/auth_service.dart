import 'package:flutter/material.dart';
import 'package:finance_control/models/Usuario.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  Usuario? _usuarioLogado;

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

  Usuario? get usuarioLogado => _usuarioLogado;

  List<Usuario> get usuarios => _usuarios;

  void cadastrar(Usuario usuario) {
    _usuarios.add(usuario);
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) {
    try {
      final usuario = _usuarios.firstWhere(
        (u) =>
            u.email == email.trim() &&
            u.senha == password.trim(),
      );

      _usuarioLogado = usuario; // 🔥 guarda o usuário logado
      _updateAuth(true);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário ou senha incorretos"),
        ),
      );
    }
  }

  void logout() {
    _usuarioLogado = null; // 🔥 limpa usuário
    _updateAuth(false);
  }

  void _updateAuth(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

final authService = AuthService();