class UserPersonalSettings {
  UserPersonalSettings({this.username = "", this.tradecode = ""});
  String username;
  String tradecode;
  factory UserPersonalSettings.fromJson(Map<String, dynamic> json) =>
      UserPersonalSettings(
        username: json["username"] ?? "",
      );
  Map<String, dynamic> toJson() => {"username": username};
}
