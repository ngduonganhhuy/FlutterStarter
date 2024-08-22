import 'package:shared_preferences/shared_preferences.dart';

class StorageKey {
  static const USER_TOKEN = 'user_token';
  static const REMEMBER_ME = 'remember_me';
  static const FIRST_LAUNCH = 'first_launch';
  static const MY_ACCOUNT = 'my_account';
  static const THEME = 'theme';
}

class StorageUtil {
  factory StorageUtil() => _instance;

  StorageUtil._internal();

  static final StorageUtil _instance = StorageUtil._internal();

  static late SharedPreferences pref;

  static Future<void> initPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> putString(String key, String data) async => pref.setString(key, data);
  static Future<bool> putInt(String key, int data) async => pref.setInt(key, data);
  static Future<bool> putBool(String key, {required bool data}) async => pref.setBool(key, data);
  static Future<bool> putDouble(String key, double data) async => pref.setDouble(key, data);
  static Future<bool> putStringList(String key, List<String> data) async => pref.setStringList(key, data);
  static Future<void> delete(String key) async => pref.remove(key);
  static String? getString(String key) => pref.getString(key);
  static List<String>? getStringList(String key) => pref.getStringList(key);
  static int? getInt(String key) => pref.getInt(key);
  static bool? getBool(String key) => pref.getBool(key);
  static double? getDouble(String key) => pref.getDouble(key);
}
