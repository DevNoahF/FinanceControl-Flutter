import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(BuildContext context, String email, String password) {
    if (email == "admin@teste.com" && password == "123") {
      _updateAuth(true);
    } else {
      // Alerta de erro simples
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário ou senha incorretos")),
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