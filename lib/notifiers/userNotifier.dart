import 'package:flutter/material.dart';
import 'package:finance_control/core/dependencyInjection/serviceLocationDI.dart';
import 'package:finance_control/adapter/httpExceptions/apiHttpException.dart';
import 'package:finance_control/data/repositories/user_api_repository.dart';
import 'package:finance_control/models/Usuario.dart';

class UserNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _erro;
  List<Usuario> _usuarios = [];
  Usuario? _selecionado;

  UserApiRepository? _repository;

  bool get loading => _loading;
  String? get erro => _erro;
  List<Usuario> get usuarios => _usuarios;
  Usuario? get selecionado => _selecionado;

  UserApiRepository _getRepository() {
    return _repository ??= getIt<UserApiRepository>();
  }

  Future<void> fetchUsers({bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = _getRepository();
      _usuarios = await repo.getUsers(forceRefresh: forceRefresh);
    } on NetworkException {
      _erro = 'Sem conexao. Tente novamente.';
    } on UnauthorizedException {
      _erro = 'Acesso nao autorizado.';
    } on NotFoundException {
      _erro = 'Usuarios nao encontrados.';
    } on FormatException {
      _erro = 'Erro ao ler dados do servidor.';
    } on ApiException catch (e) {
      _erro = e.message;
    } catch (_) {
      _erro = 'Erro ao carregar usuarios.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserById(int id, {bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = _getRepository();
      _selecionado = await repo.getUserById(id, forceRefresh: forceRefresh);
    } on NetworkException {
      _erro = 'Sem conexao. Tente novamente.';
    } on UnauthorizedException {
      _erro = 'Acesso nao autorizado.';
    } on NotFoundException {
      _erro = 'Usuario nao encontrado.';
    } on FormatException {
      _erro = 'Erro ao ler dados do servidor.';
    } on ApiException catch (e) {
      _erro = e.message;
    } catch (_) {
      _erro = 'Erro ao carregar usuario.';
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
