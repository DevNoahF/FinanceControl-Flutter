import 'package:flutter/material.dart';
import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/repositories/user_api_repository.dart';
import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/data/services/user_service.dart';
import 'package:finance_control/models/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<UserApiRepository> _getRepository() async {
    if (_repository != null) return _repository!;
    final prefs = await SharedPreferences.getInstance();
    final cache = CacheService(prefs);
    final client = ApiClient(baseUrl: 'https://jsonplaceholder.typicode.com');
    final service = UserService(client);
    _repository = UserApiRepository(service: service, cache: cache);
    return _repository!;
  }

  Future<void> fetchUsers({bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = await _getRepository();
      _usuarios = await repo.getUsers(forceRefresh: forceRefresh);
    } catch (e) {
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
      final repo = await _getRepository();
      _selecionado = await repo.getUserById(id, forceRefresh: forceRefresh);
    } catch (e) {
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
