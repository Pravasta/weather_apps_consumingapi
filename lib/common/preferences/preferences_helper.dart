import 'package:shared_preferences/shared_preferences.dart';

class PreferedHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferedHelper({required this.sharedPreferences});

  Future<String?> getPrefs(String key) async {
    final pref = await sharedPreferences;
    final result = pref.getString(key);
    return result;
  }

  Future<void> setPrefs(String key, String value) async {
    final pref = await sharedPreferences;
    pref.setString(key, value);
  }
}
