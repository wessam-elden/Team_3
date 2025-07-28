import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // Initialization
  static Future<void> init() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      print("SharedPreferences initialized successfully.");
    } catch (e) {
      print("Error initializing SharedPreferences: $e");
      throw Exception("Failed to initialize SharedPreferences");
    }
  }

  // Save Data
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value == null) throw Exception("Cannot save null value to cache for key: $key");

    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);

    throw Exception("Unsupported value type");
  }

  // Get Data
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Remove
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // Contains
  static bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  // Clear All
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
