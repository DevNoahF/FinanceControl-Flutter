import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/services/admin_service.dart';
import 'package:finance_control/models/admin.dart';

class AdminApiRepository {
  final AdminService _service;
  final CacheService _cache;
  final Duration _cacheTtl;

  AdminApiRepository({
    required AdminService service,
    required CacheService cache,
    Duration cacheTtl = const Duration(minutes: 10),
  })  : _service = service,
        _cache = cache,
        _cacheTtl = cacheTtl;

  Future<List<Admin>> getAdmins({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _cache.getJson(_adminsKey, _cacheTtl);
      if (cached is List) {
        try {
          return cached
              .map((item) => Admin.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (_) {

        }
      }
    }

    final admins = await _service.getAdmins();
    await _cache.setJson(
      _adminsKey,
      admins.map((admin) => admin.toJson()).toList(),
    );
    return admins;
  }

  Future<Admin?> getAdminByEmail(String email,
      {bool forceRefresh = false}) async {
    final key = _adminKey(email);
    if (!forceRefresh) {
      final cached = await _cache.getJson(key, _cacheTtl);
      if (cached is Map<String, dynamic>) {
        try {
          return Admin.fromJson(cached);
        } catch (_) {
        
        }
      }
    }

    final admin = await _service.getAdminByEmail(email);
    if (admin == null) return null;
    await _cache.setJson(key, admin.toJson());
    return admin;
  }

  static String _adminKey(String email) => 'cache_admin_${email.trim()}';
  static const String _adminsKey = 'cache_admins';
}
