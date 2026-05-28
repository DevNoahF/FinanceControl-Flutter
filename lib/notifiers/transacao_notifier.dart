import 'package:flutter/material.dart';

import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/domain/repositories/transacao_repository.dart';
import '../models/transacao.dart';

/// ChangeNotifier responsável por toda a lógica de transações.
class TransacaoNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _erro;

  ITransacaoRepository get _transacaoRepository => getIt<ITransacaoRepository>();

  bool get loading => _loading;
  String? get erro => _erro;

 
  String? validar({
    required String titulo,
    required String valorRaw,
    required String descricao,
  }) {
    if (titulo.trim().isEmpty) return 'O título é obrigatório';
    if (descricao.trim().isEmpty) return 'A descrição é obrigatória';

    final valor = double.tryParse(valorRaw.replaceAll(',', '.'));
    if (valor == null) return 'Digite um valor numérico válido';
    if (valor <= 0) return 'O valor deve ser maior que zero';

    return null; // sem erros
  }

   Future<bool> salvar({
    required String titulo,
    required String descricao,
    required String valorRaw,
    required String tipo,
  }) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final valor = double.parse(valorRaw.replaceAll(',', '.'));
      final usuarioId = authService.usuarioLogado?.id;

      if (usuarioId == null) {
        _erro = 'Faça login novamente para salvar a transação.';
        return false;
      }

      await _transacaoRepository.insert(
        Transacao(
          userId: usuarioId,
          titulo: titulo,
          descricao: descricao,
          valor: valor,
          isEntrada: tipo == 'entrada',
        ),
      );

      return true;
    } catch (e) {
      _erro = 'Erro ao salvar transação. Tente novamente.';
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