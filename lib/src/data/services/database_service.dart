import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  DatabaseService();

  Future<bool?> saveList(String key, List<String> list) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      bool result = await preferences.setStringList(key, list);
      return result;
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return false;
  }

    Future<List<String>?> getList(String key) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      List<String>? result = await preferences.getStringList(key);
      return result;
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return null;
  }
}
