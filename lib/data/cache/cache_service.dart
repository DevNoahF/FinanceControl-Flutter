import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  final SharedPreferences _prefs;

  const CacheService(this._prefs);

  Future<void> setJson(String key, dynamic data) async {
    final payload = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };
    await _prefs.setString(key, jsonEncode(payload));
  }

  Future<dynamic> getJson(String key, Duration maxAge) async {
    final raw = _prefs.getString(key);
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final timestamp = decoded['timestamp'] as String;
      final cachedAt = DateTime.parse(timestamp);
      final expired = DateTime.now().difference(cachedAt) > maxAge;
      if (expired) {
        await _prefs.remove(key);
        return null;
      }
      return decoded['data'];
    } catch (_) {
      await _prefs.remove(key);
      return null;
    }
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

}
