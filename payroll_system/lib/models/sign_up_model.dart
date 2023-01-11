// To parse this JSON data, do
//
//     final aboutDetailsModel = aboutDetailsModelFromJson(jsonString);

import 'dart:convert';

RegisterModel aboutDetailsModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(RegisterModel data) =>
    json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final Data data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? '',
        data: Data.fromJson(json["Data"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userName,
    required this.email,
    required this.fullName,
    required this.phoneno,
    required this.isActive,
    required this.roleId,
    // required this.updatedAt,
    // required this.createdAt,
    required this.id,
  });

  final String userName;
  final String email;
  final String fullName;
  final String phoneno;
  final String isActive;
  final String roleId;
  // final DateTime updatedAt;
  // final DateTime createdAt;
  final String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        phoneno: json["phoneno"] ?? "",
        isActive: json["is_active"] ?? "",
        roleId: json["role_id"] ?? "0",
        // updatedAt: DateTime.parse(json["updated_at"]),
        // createdAt: DateTime.parse(json["created_at"]),
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "email": email,
        "full_name": fullName,
        "phoneno": phoneno,
        "is_active": isActive,
        "role_id": roleId,
        // "updated_at": updatedAt.toIso8601String(),
        // "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
