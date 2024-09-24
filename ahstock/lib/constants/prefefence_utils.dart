import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<bool> preferenceHasKey(String key) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    return prefsInstance.containsKey(key);
  }

  static storeDataToShared(String key, String data) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.remove(key);
    prefsInstance.setString(key, data);
  }

  static removeDataFromShared(String key) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.remove(key);
  }

  static clear() async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.clear();
  }

  static Future<String?> getDataFromShared(String key) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();
    return prefInstance.getString(key);
  }

  static storestringlist(String key, List<String> list) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();
    prefInstance.setStringList(key, list);
  }

  static storeListmap(String key, List<Map<String, dynamic>> listdata) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    final String encodelist = jsonEncode(listdata);

    prefInstance.setString(key, encodelist);
  }

  static Future<List<dynamic>> getstoremap(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final String? list = preferences.getString(key);

    if (list != null) {
      final List<dynamic> dataList = jsonDecode(list);
      return dataList;
    } else {
      return [];
    }
  }

  static Future<List<String>?> getdatafromlist(String key) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();
    List<String> messagesString = prefInstance.getStringList(key) ?? [];
    return messagesString;
  }

  static saveBooleanFromSharedPreferences(String key, bool value) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    prefInstance.setBool(key, value);
  }

  static Future<bool?> getBooleanFromSharedPreferences(String key) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    return prefInstance.getBool(key);
  }
}
