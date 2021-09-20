import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static Future<bool> saveData(
      {required String data, required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, data);
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    return data;
  }
}
