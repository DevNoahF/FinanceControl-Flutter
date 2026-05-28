import 'package:finance_control/models/admin.dart';

abstract interface class IAdminRepository {
	Future<int> insert(Admin admin);
	Future<List<Admin>> getAll();
	Future<Admin?> getById(int id);
	Future<Admin?> getByEmail(String email);
	Future<int> update(Admin admin);
	Future<int> delete(int id);
}