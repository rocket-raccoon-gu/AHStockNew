// To parse this JSON data, do
//
//     final profileResponce = profileResponceFromJson(jsonString);

import 'dart:convert';

ProfileResponce profileResponceFromJson(String str) =>
    ProfileResponce.fromJson(json.decode(str));

String profileResponceToJson(ProfileResponce data) =>
    json.encode(data.toJson());

class ProfileResponce {
  int success;
  List<User> user;

  ProfileResponce({
    required this.success,
    required this.user,
  });

  factory ProfileResponce.fromJson(Map<String, dynamic> json) =>
      ProfileResponce(
        success: json["success"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class User {
  String id;
  String empId;
  String name;
  String status;
  String approveStatus;
  String email;
  String mobileNumber;
  String vehicleNumber;
  String availabilityStatus;
  String vehicleType;
  String password;
  String address;
  String role;
  String regularShiftTime;
  String fridayShiftTime;
  String offDay;
  dynamic latitude;
  dynamic longitude;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic rpToken;
  DateTime rpTokenCreatedAt;

  User({
    required this.id,
    required this.empId,
    required this.name,
    required this.status,
    required this.approveStatus,
    required this.email,
    required this.mobileNumber,
    required this.vehicleNumber,
    required this.availabilityStatus,
    required this.vehicleType,
    required this.password,
    required this.address,
    required this.role,
    required this.regularShiftTime,
    required this.fridayShiftTime,
    required this.offDay,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.rpToken,
    required this.rpTokenCreatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        empId: json["emp_id"],
        name: json["name"],
        status: json["status"],
        approveStatus: json["approve_status"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        vehicleNumber: json["vehicle_number"],
        availabilityStatus: json["availability_status"],
        vehicleType: json["vehicle_type"],
        password: json["password"],
        address: json["address"],
        role: json["role"],
        regularShiftTime: json["regular_shift_time"],
        fridayShiftTime: json["friday_shift_time"],
        offDay: json["off_day"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rpToken: json["rp_token"],
        rpTokenCreatedAt: DateTime.parse(json["rp_token_created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "name": name,
        "status": status,
        "approve_status": approveStatus,
        "email": email,
        "mobile_number": mobileNumber,
        "vehicle_number": vehicleNumber,
        "availability_status": availabilityStatus,
        "vehicle_type": vehicleType,
        "password": password,
        "address": address,
        "role": role,
        "regular_shift_time": regularShiftTime,
        "friday_shift_time": fridayShiftTime,
        "off_day": offDay,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rp_token": rpToken,
        "rp_token_created_at": rpTokenCreatedAt.toIso8601String(),
      };
}
