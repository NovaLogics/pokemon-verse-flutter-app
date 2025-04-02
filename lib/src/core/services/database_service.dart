import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service class for handling local storage operations using SharedPreferences.
class DatabaseService {
  DatabaseService();

  /// Saves a list of strings to SharedPreferences with the given [key].
  Future<bool> saveStringList(String key, List<String> values) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setStringList(key, values);
    } catch (exception) {
      if (kDebugMode) {
        print('Failed to save list: $exception');
      }
      return false;
    }
  }

  /// Retrieves a list of strings from SharedPreferences using the given [key].
  Future<List<String>?> getStringList(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(key);
    } catch (exception) {
      if (kDebugMode) {
        print('Failed to retrieve list: $exception');
      }
      return null;
    }
  }
}