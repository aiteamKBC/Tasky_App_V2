import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManger {
  static final PreferencesManger _instance = PreferencesManger._internal();
  factory PreferencesManger() {
    return _instance;
  }

  PreferencesManger._internal();

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  bool? getBool(String key) {
  return _preferences.getBool(key);
}

int? getInt(String key) {
  return _preferences.getInt(key);
}

double? getDouble(String key) {
  return _preferences.getDouble(key);
}

Future<bool> setBool(String key, bool value) {
  return _preferences.setBool(key, value);
}

Future<bool> setInt(String key, int value) {
  return _preferences.setInt(key, value);
}

Future<bool> setDouble(String key, double value) {
  return _preferences.setDouble(key, value);
}
}
