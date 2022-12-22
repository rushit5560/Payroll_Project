// To parse this JSON data, do
//
//     final aboutDetailsModel = aboutDetailsModelFromJson(jsonString);

import 'dart:convert';

LogInDetails aboutDetailsModelFromJson(String str) =>
    LogInDetails.fromJson(json.decode(str));

String aboutDetailsModelToJson(LogInDetails data) => json.encode(data.toJson());

class LogInDetails {
  LogInDetails({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final Data data;

  factory LogInDetails.fromJson(Map<String, dynamic> json) => LogInDetails(
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
    required this.id,
    this.token,
    required this.data,
  });

  final int id;
  final dynamic token;
  final DataClass data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["ID"],
        token: json["Token"],
        data: DataClass.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Token": token,
        "data": data.toJson(),
      };
}

class DataClass {
  DataClass({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.fullName,
    required this.address,
    required this.phoneno,
    required this.roleId,
    required this.isActive,
    // this.lastlogin,
    required this.verified,
    required this.createdby,
    // this.modifiedby,
    required this.emailVerifiedAt,
    required this.photo,
    // this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String userName;
  final String email;
  final String password;
  final String fullName;
  final String address;
  final String phoneno;
  final int roleId;
  final String isActive;
  // final dynamic lastlogin;
  final String verified;
  final int createdby;
  // final dynamic modifiedby;
  final String emailVerifiedAt;
  final String photo;
  // final dynamic rememberToken;
  final String createdAt;
  final String updatedAt;

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        id: json["id"] ?? 0,
        userName: json["user_name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        fullName: json["full_name"] ?? '',
        address: json["address"] ?? '',
        phoneno: json["phoneno"] ?? '',
        roleId: json["role_id"] ?? 0,
        isActive: json["is_active"] ?? '',
        // lastlogin: json["lastlogin"],
        verified: json["verified"] ?? '',
        createdby: json["createdby"] ?? 0,
        // modifiedby: json["modifiedby"],
        emailVerifiedAt: json["email_verified_at"] ?? '',
        photo: json["photo"] ?? '',
        // rememberToken: json["remember_token"],
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "password": password,
        "full_name": fullName,
        "address": address,
        "phoneno": phoneno,
        "role_id": roleId,
        "is_active": isActive,
        // "lastlogin": lastlogin,
        "verified": verified,
        "createdby": createdby,
        // "modifiedby": modifiedby,
        "email_verified_at": emailVerifiedAt,
        "photo": photo,
        // "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
