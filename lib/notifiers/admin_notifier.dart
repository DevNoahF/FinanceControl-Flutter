import 'package:flutter/material.dart';
import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/repositories/admin_api_repository.dart';
import 'package:finance_control/data/services/admin_service.dart';
import 'package:finance_control/data/services/api_client.dart';
import 'package:finance_control/models/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _erro;
  List<Admin> _admins = [];
  Admin? _selecionado;

  AdminApiRepository? _repository;

  bool get loading => _loading;
  String? get erro => _erro;
  List<Admin> get admins => _admins;
  Admin? get selecionado => _selecionado;

  Future<AdminApiRepository> _getRepository() async {
    if (_repository != null) return _repository!;
    final prefs = await SharedPreferences.getInstance();
    final cache = CacheService(prefs);
    final client = ApiClient(baseUrl: 'https://jsonplaceholder.typicode.com');
    final service = AdminService(client);
    _repository = AdminApiRepository(service: service, cache: cache);
    return _repository!;
  }

  Future<void> fetchAdmins({bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = await _getRepository();
      _admins = await repo.getAdmins(forceRefresh: forceRefresh);
    } catch (e) {
      _erro = 'Erro ao carregar admins.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAdminByEmail(String email,
      {bool forceRefresh = false}) async {
    _loading = true;
    _erro = null;
    notifyListeners();

    try {
      final repo = await _getRepository();
      _selecionado = await repo.getAdminByEmail(
        email,
        forceRefresh: forceRefresh,
      );
    } catch (e) {
      _erro = 'Erro ao carregar admin.';
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
