import 'dart:async';

import 'package:flutter/material.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/data/session/api_session.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:finance_control/models/Usuario.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  Usuario? _usuarioLogado;

  IUsuarioRepository get _usuarioRepository => getIt<IUsuarioRepository>();

  bool get isAuthenticated => _isAuthenticated;

  Usuario? get usuarioLogado => _usuarioLogado;

  Future<void> ensureSeed() async {
    final admin = await _usuarioRepository.getByEmail('admin@teste.com');
    if (admin == null) {
      await _usuarioRepository.insert(
        Usuario(
          id: 0,
          nome: 'Admin',
          sobrenome: 'Teste',
          email: 'admin@teste.com',
          senha: Usuario.hashSenha('123'),
          idade: 20,
          profissao: 'Administrador',
          role: 'adm',
          created_at: DateTime.now(),
        ),
      );
    }
  }

  Future<bool> cadastrar(Usuario usuario) async {
    await _usuarioRepository.insert(
      usuario.copyWith(senha: Usuario.hashSenha(usuario.senha)),
    );
    notifyListeners();
    return true;
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      final usuario = await _usuarioRepository.getByEmail(email.trim());

      if (usuario == null || usuario.senha != Usuario.hashSenha(password)) {
        throw Exception('Credenciais inválidas');
      }

      _usuarioLogado = usuario;
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
    _usuarioLogado = null;
    _updateAuth(false);
    if (getIt.isRegistered<ApiSession>()) {
      unawaited(getIt<ApiSession>().clear());
    }
  }

  void _updateAuth(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

final authService = AuthService();