import 'package:flutter/material.dart';

import '../models/transacao.dart';
import '../data/transacoes_data.dart';

/// ChangeNotifier responsável por toda a lógica de transações.
/// Registrado no GetIt e exposto via MultiProvider na raiz da aplicação.
class TransacaoNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _erro;

  bool get loading => _loading;
  String? get erro => _erro;

  // ------------------------------------------------------------------ //
  //  Validação (saiu da tela)
  // ------------------------------------------------------------------ //

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

  // ------------------------------------------------------------------ //
  //  Ação principal (saiu da tela)
  // ------------------------------------------------------------------ //

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

      transacoes.add(
        Transacao(
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

  /// Limpa o estado de erro (útil ao reabrir a tela)
  void limparErro() {
    _erro = null;
    notifyListeners();
  }
}