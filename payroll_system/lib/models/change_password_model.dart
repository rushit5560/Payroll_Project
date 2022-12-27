// To parse this JSON changePasswordData, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) =>
    ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel changePasswordData) =>
    json.encode(changePasswordData.toJson());

class ChangePasswordModel {
  ChangePasswordModel({
    required this.success,
    required this.message,
    // required this.changePasswordData,
  });

  final bool success;
  final String message;
  // final ChangePasswordchangePasswordData changePasswordData;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        // changePasswordData: ChangePasswordchangePasswordData.fromJson(
        //     json["changePasswordData"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        // "changePasswordData": changePasswordData,
      };
}

// class ChangePasswordchangePasswordData {
  // ChangePasswordchangePasswordData({
  //   required this.id,
  //   required this.userName,
  //   required this.email,
  //   required this.fullName,
  //   required this.address,
  //   required this.phoneno,
  //   required this.roleId,
  //   this.departmentId,
  //   this.locationId,
  //   required this.isActive,
  //   this.lastlogin,
  //   required this.verified,
  //   required this.createdby,
  //   this.modifiedby,
  //   this.emailVerifiedAt,
  //   required this.photo,
  //   required this.createdAt,
  //   required this.updatedAt,
  // });

  // final int id;
  // final String userName;
  // final String email;
  // final String fullName;
  // final String address;
  // final String phoneno;
  // final int roleId;
  // final dynamic departmentId;
  // final dynamic locationId;
  // final String isActive;
  // final dynamic lastlogin;
  // final String verified;
  // final int createdby;
  // final dynamic modifiedby;
  // final dynamic emailVerifiedAt;
  // final String photo;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  // factory ChangePasswordchangePasswordData.fromJson(
  //         Map<String, dynamic> json) =>
  //     ChangePasswordchangePasswordData(
  //       id: json["id"],
  //       userName: json["user_name"],
  //       email: json["email"],
  //       fullName: json["full_name"],
  //       address: json["address"],
  //       phoneno: json["phoneno"],
  //       roleId: json["role_id"],
  //       departmentId: json["department_id"],
  //       locationId: json["location_id"],
  //       isActive: json["is_active"],
  //       lastlogin: json["lastlogin"],
  //       verified: json["verified"],
  //       createdby: json["createdby"],
  //       modifiedby: json["modifiedby"],
  //       emailVerifiedAt: json["email_verified_at"],
  //       photo: json["photo"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //     );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "user_name": userName,
  //     "email": email,
  //     "full_name": fullName,
  //     "address": address,
  //     "phoneno": phoneno,
  //     "role_id": roleId,
  //     "department_id": departmentId,
  //     "location_id": locationId,
  //     "is_active": isActive,
  //     "lastlogin": lastlogin,
  //     "verified": verified,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "email_verified_at": emailVerifiedAt,
  //     "photo": photo,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  // };
// }
// 