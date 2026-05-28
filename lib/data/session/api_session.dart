import 'package:shared_preferences/shared_preferences.dart';

class ApiSession {
  static const String _tokenKey = 'finance_api_token';

  final SharedPreferences _prefs;

  const ApiSession(this._prefs);

  String? get token {
    final value = _prefs.getString(_tokenKey);
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value.trim();
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token.trim());
  }

  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
  }
}