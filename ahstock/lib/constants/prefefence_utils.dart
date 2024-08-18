import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<bool> preferenceHasKey(String key) async {
    SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance.containsKey(key);
  }

  static storeDataToShared(String key, String data) async {
    SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    _prefsInstance.remove(key);
    _prefsInstance.setString(key, data);
  }

  static removeDataFromShared(String key) async {
    SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    _prefsInstance.remove(key);
  }

  static clear() async {
    SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    _prefsInstance.clear();
  }

  static Future<String?> getDataFromShared(String key) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();
    return _prefInstance.getString(key);
  }

  static storestringlist(String key, List<String> list) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();
    _prefInstance.setStringList(key, list);
  }

  static storeListmap(String key, List<Map<String, dynamic>> listdata) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();

    final String encodelist = jsonEncode(listdata);

    _prefInstance.setString(key, encodelist);
  }

  static Future<List<dynamic>> getstoremap(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    final String? list = _preferences.getString(key);

    if (list != null) {
      final List<dynamic> dataList = jsonDecode(list);
      return dataList;
    } else {
      return [];
    }
  }

  static Future<List<String>?> getdatafromlist(String key) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();
    List<String> messagesString = _prefInstance.getStringList(key) ?? [];
    return messagesString;
  }

  static saveBooleanFromSharedPreferences(String key, bool value) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();

    _prefInstance.setBool(key, value);
  }

  static Future<bool?> getBooleanFromSharedPreferences(String key) async {
    SharedPreferences _prefInstance = await SharedPreferences.getInstance();

    return _prefInstance.getBool(key);
  }
}
