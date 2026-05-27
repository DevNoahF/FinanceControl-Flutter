import 'package:finance_control/data/cache/cache_service.dart';
import 'package:finance_control/data/services/user_service.dart';
import 'package:finance_control/models/Usuario.dart';

class UserApiRepository {
	final UserService _service;
	final CacheService _cache;
	final Duration _cacheTtl;

	const UserApiRepository({
		required UserService service,
		required CacheService cache,
		Duration cacheTtl = const Duration(minutes: 10),
	})  : _service = service,
				_cache = cache,
				_cacheTtl = cacheTtl;

	Future<List<Usuario>> getUsers({bool forceRefresh = false}) async {
		if (!forceRefresh) {
			final cached = await _cache.getJson(_usersKey, _cacheTtl);
			if (cached is List) {
				try {
					return cached
							.map((item) => Usuario.fromJson(item as Map<String, dynamic>))
							.toList();
				} catch (_) {
					// ignore and fetch from API
				}
			}
		}

		final users = await _service.getUsers();
		await _cache.setJson(
			_usersKey,
			users.map((user) => user.toJson()).toList(),
		);
		return users;
	}

	Future<Usuario> getUserById(int id, {bool forceRefresh = false}) async {
		final key = _userKey(id);
		if (!forceRefresh) {
			final cached = await _cache.getJson(key, _cacheTtl);
			if (cached is Map<String, dynamic>) {
				try {
					return Usuario.fromJson(cached);
				} catch (_) {
					// ignore and fetch from API
				}
			}
		}

		final user = await _service.getUserById(id);
		await _cache.setJson(key, user.toJson());
		return user;
	}

	static String _userKey(int id) => 'cache_user_$id';
	static const String _usersKey = 'cache_users';
}
