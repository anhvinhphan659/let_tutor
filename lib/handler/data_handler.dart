import 'package:shared_preferences/shared_preferences.dart';

class DataHandler {
  static late final SharedPreferences prefInstance;
  static Future<void> initial() async {
    prefInstance = await SharedPreferences.getInstance();
  }

  static Future<void> setData(String key, String value) async {
    await prefInstance.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    return await prefInstance.getString(key);
  }

  static Future<void> removeKey(String key) async {
    await prefInstance.remove(key);
  }
}
