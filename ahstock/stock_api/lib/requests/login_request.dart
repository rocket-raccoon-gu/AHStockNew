// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.version,
  });

  String username;
  String password;
  String version;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
      username: json["emp_id"],
      password: json["password"],
      version: json["version"]);

  Map<String, dynamic> toJson() =>
      {"emp_id": username, "password": password, "version": version};
}
