import 'package:shared_preferences/shared_preferences.dart';

// key-value本地数据存储
class LocalStorage {
  static SharedPreferences? prefs;

  static initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  static set(String key, String value) {
    prefs?.setString(key, value);
  }

  static String? get(String key) {
    return prefs?.getString(key);
  }

  static remove(String key) {
    prefs?.remove(key);
  }
}
