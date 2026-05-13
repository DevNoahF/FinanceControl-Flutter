import 'package:flutter/material.dart';

import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/models/Usuario.dart';

/// ChangeNotifier responsável por toda a lógica de cadastro.
class CadastroNotifier extends ChangeNotifier {
  final AuthService _authService = authService;

  bool _loading = false;
  String? _erro;

  bool get loading => _loading;
  String? get erro => _erro;

  // ------------------------------------------------------------------ //
  //  Helpers de domínio (saíram da tela)
  // ------------------------------------------------------------------ //

  int calcularIdade(DateTime nascimento) {
    final hoje = DateTime.now();
    int idade = hoje.year - nascimento.year;

    if (hoje.month < nascimento.month ||
        (hoje.month == nascimento.month && hoje.day < nascimento.day)) {
      idade--;
    }

    return idade;
  }

  DateTime? converterDataNascimento(String value) {
    try {
      final partes = value.split('/');

      final dia = int.parse(partes[0]);
      final mes = int.parse(partes[1]);
      final ano = int.parse(partes[2]);

      return DateTime(ano, mes, dia);
    } catch (_) {
      return null;
    }
  }

  // ------------------------------------------------------------------ //
  //  Ação principal
  // ------------------------------------------------------------------ //

  Future<bool> cadastrar(Usuario usuario) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      _authService.cadastrar(usuario);
      return true;
    } catch (e) {
      _erro = 'Erro ao criar conta. Tente novamente.';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Limpa o estado de erro (útil ao reabrir a tela)
  void limparErro() {
    _erro = null;
    notifyListeners();
  }
}