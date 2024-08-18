import 'dart:convert';

import 'package:ahstock/utils/user_personal_settings.dart';

class UserSettings {
  static final UserSettings userSettings = UserSettings._privateConstructor();
  UserSettings._privateConstructor()
      : userPersonalSettings = UserPersonalSettings();

  factory UserSettings() {
    return userSettings;
  }
  String version = "";
  int otpSecondsDelay = 0;
  int portfolioIndex = 0;
  int orderbookIndex = 0;
  String currentTheme = "Light";
  String presetWatchlist = "";
  UserPersonalSettings userPersonalSettings;

  Map<String, dynamic> toJson() => {
        "userPersonalSettings": userPersonalSettings,
        "OrderbookIndex": orderbookIndex,
        "Version": version,
        "OtpSecondsDelay": otpSecondsDelay
      };

  UserSettings fromJson(Map<String, dynamic> json) {
    UserSettings().orderbookIndex = json["OrderbookIndex"] ?? 0;
    UserSettings().portfolioIndex = json["portfolioIndex"] ?? 0;
    UserSettings.userSettings.currentTheme = json["currentTheme"] ?? "Light";
    UserSettings.userSettings.userPersonalSettings =
        UserPersonalSettings.fromJson(
            json["userPersonalSettings"] ?? UserPersonalSettings().toJson());
    UserSettings.userSettings.version = json["Version"] ?? "";
    UserSettings.userSettings.otpSecondsDelay = json["OtpSecondsDelay"] ?? 0;
    return UserSettings.userSettings;
  }

  UserSettings fromJsonString(String str) {
    return str.isEmpty ? UserSettings() : fromJson(json.decode(str));
  }

  String toJsonString() => json.encode(userSettings.toJson());
}
