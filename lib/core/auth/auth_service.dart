import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _updateAuth(true);
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