// To parse this JSON data, do
//
//     final aboutDetailsModel = aboutDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:payroll/models/user_permission_model/user_permission_model.dart';

LoginDetailsModel aboutDetailsModelFromJson(String str) =>
    LoginDetailsModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(LoginDetailsModel data) =>
    json.encode(data.toJson());

class LoginDetailsModel {
  LoginDetailsModel({
    required this.success,
    required this.messege,
    required this.loginData,
    required this.error,
  });

  final bool success;
  final String messege;
  final LoginData loginData;
  String error;

  factory LoginDetailsModel.fromJson(Map<String, dynamic> json) =>
      LoginDetailsModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        loginData: LoginData.fromJson(json["Data"] ?? {}),
        error: json["error"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": loginData.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.id,
    required this.token,
    required this.data,
    required this.permissiondata,
    required this.dateformat,
  });

  final String id;
  final String token;
  final UserData data;
  final PermissionData permissiondata;
  String dateformat;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: (json["ID"] ?? 0).toString(),
        token: json["Token"] ?? "",
        data: UserData.fromJson(json["data"] ?? {}),
        permissiondata: PermissionData.fromJson(json["permissiondata"] ?? {}),
        dateformat: json["dateformat"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Token": token,
        "data": data.toJson(),
        "permissiondata": permissiondata.toJson(),
        "dateformat": dateformat,
      };
}

class UserData {
  UserData({
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
    required this.city,
    required this.state,
    required this.town,
    required this.street,
    // this.modifiedby,
    required this.zipcode,
    required this.emailVerifiedAt,
    required this.photo,
    required this.employeeId,

    // this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userName;
  final String email;
  final String password;
  final String fullName;
  final String address;
  final String phoneno;
  final String roleId;
  final String isActive;
  // final dynamic lastlogin;
  final String verified;
  final String createdby;
  // final dynamic modifiedby;
  final String emailVerifiedAt;
  final String photo;
  final String street;
  final String town;
  final String state;
  final String city;
  String employeeId;
  final String zipcode;
  // final dynamic rememberToken;
  final String createdAt;
  final String updatedAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: (json["id"] ?? 0).toString(),
        userName: json["user_name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        fullName: json["full_name"] ?? '',
        address: json["address"] ?? '',
        phoneno: json["phoneno"] ?? '',
        roleId: (json["role_id"] ?? 0).toString(),
        isActive: json["is_active"] ?? '',
        // lastlogin: json["lastlogin"],
        verified: json["verified"] ?? '',
        createdby: (json["createdby"] ?? 0).toString(),
        // modifiedby: json["modifiedby"],
        emailVerifiedAt: json["email_verified_at"] ?? '',
        employeeId: (json["employee_id"] ?? 0).toString(),

        photo: json["photo"] ?? '',
        city: json["city"] ?? "",
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        zipcode: json["zipcode"] ?? "",

        state: json["state"] ?? "",
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

class Error {
  Error({
    required this.success,
    required this.error,
  });

  final bool success;
  final String error;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
      };
}
