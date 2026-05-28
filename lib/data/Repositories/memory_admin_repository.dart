import 'package:finance_control/domain/repositories/admin_repository.dart';
import 'package:finance_control/models/admin.dart';

class MemoryAdminRepository implements IAdminRepository {
  final List<Admin> _admins = [];

  @override
  Future<int> insert(Admin admin) async {
    _admins.add(admin);
    return _admins.length;
  }

  @override
  Future<List<Admin>> getAll() async => List.unmodifiable(_admins);

  @override
  Future<Admin?> getById(int id) async => null;

  @override
  Future<Admin?> getByEmail(String email) async {
    try {
      return _admins.firstWhere((admin) => admin.email == email.trim());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> update(Admin admin) async {
    final index = _admins.indexWhere((item) => item.email == admin.email);
    if (index == -1) return 0;
    _admins[index] = admin;
    return 1;
  }

  @override
  Future<int> delete(int id) async => 0;
}