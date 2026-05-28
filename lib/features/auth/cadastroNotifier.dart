import 'package:flutter/material.dart';

import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/domain/repositories/usuario_repository.dart';
import 'package:finance_control/models/Usuario.dart';


class CadastroNotifier extends ChangeNotifier {
  final AuthService _authService = authService;
  IUsuarioRepository get _usuarioRepository => getIt<IUsuarioRepository>();

  bool _loading = false;
  String? _erro;

  bool get loading => _loading;
  String? get erro => _erro;



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



  Future<bool> cadastrar(Usuario usuario) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      await _usuarioRepository.insert(
        usuario.copyWith(senha: Usuario.hashSenha(usuario.senha)),
      );
      await _authService.ensureSeed();
      return true;
    } catch (e) {
      _erro = 'Erro ao criar conta. Tente novamente.';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void limparErro() {
    _erro = null;
    notifyListeners();
  }
}