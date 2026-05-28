import 'package:flutter/material.dart';
import 'package:finance_control/core/di/service_locator.dart';
import 'package:finance_control/data/exceptions/api_exceptions.dart';
import 'package:finance_control/data/repositories/transacao_api_repository.dart';
import 'package:finance_control/models/transacao.dart';

class TransacaoApiNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _erro;
  List<Transacao> _transacoes = [];
  Transacao? _selecionada;

  TransacaoApiRepository? _repository;

  bool get loading => _loading;
  String? get erro => _erro;
  List<Transacao> get transacoes => _transacoes;
  Transacao? get selecionada => _selecionada;

  TransacaoApiRepository _getRepository() {
    return _repository ??= getIt<TransacaoApiRepository>();
  }

  Future<void> fetchTransacoes({bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = _getRepository();
      _transacoes = await repo.getTransacoes(forceRefresh: forceRefresh);
    } on NetworkException {
      _erro = 'Sem conexao. Tente novamente.';
    } on UnauthorizedException {
      _erro = 'Acesso nao autorizado.';
    } on NotFoundException {
      _erro = 'Transacoes nao encontradas.';
    } on FormatException {
      _erro = 'Erro ao ler dados do servidor.';
    } on ApiException catch (e) {
      _erro = e.message;
    } catch (_) {
      _erro = 'Erro ao carregar transacoes.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTransacaoById(int id, {bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = _getRepository();
      _selecionada = await repo.getTransacaoById(
        id,
        forceRefresh: forceRefresh,
      );
    } on NetworkException {
      _erro = 'Sem conexao. Tente novamente.';
    } on UnauthorizedException {
      _erro = 'Acesso nao autorizado.';
    } on NotFoundException {
      _erro = 'Transacao nao encontrada.';
    } on FormatException {
      _erro = 'Erro ao ler dados do servidor.';
    } on ApiException catch (e) {
      _erro = e.message;
    } catch (_) {
      _erro = 'Erro ao carregar transacao.';
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
