import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesDataSource(this.sharedPreferences);

  Future<void> saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }
}
