// To parse this JSON data, do
//
//     final CompanyProfileModel = CompanyProfileModelFromJson(jsonString);

import 'dart:convert';

CompanyProfileModel companyProfileModelFromJson(String str) =>
    CompanyProfileModel.fromJson(json.decode(str));

String companyProfileModelToJson(CompanyProfileModel data) =>
    json.encode(data.toJson());

class CompanyProfileModel {
  CompanyProfileModel({
    required this.success,
    required this.message,
    required this.companyData,
  });

  final bool success;
  final String message;
  final CompanyData companyData;

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyProfileModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        companyData: CompanyData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": companyData.toJson(),
      };
}

class CompanyData {
  CompanyData({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.address,
    required this.phoneno,
    required this.roleId,
    required this.departmentId,
    required this.locationId,
    required this.isActive,
    // this.lastlogin,
    required this.verified,
    required this.createdby,
    required this.modifiedby,
    // this.emailVerifiedAt,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String userName;
  final String email;
  final String fullName;
  final String address;
  final String phoneno;
  final String roleId;
  final String departmentId;
  final String locationId;
  final String isActive;
  // final dynamic lastlogin;
  final String verified;
  final String createdby;
  final String modifiedby;
  // final dynamic emailVerifiedAt;
  final String photo;
  final String createdAt;
  final String updatedAt;

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        id: json["id"] ?? 0,
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        address: json["address"] ?? "",
        phoneno: json["phoneno"] ?? "",
        roleId: json["role_id"] ?? "",
        departmentId: json["department_id"] ?? "",
        locationId: json["location_id"] ?? "",
        isActive: json["is_active"] ?? "",
        // lastlogin: json["lastlogin"] ?? "",
        verified: json["verified"] ?? "",
        createdby: json["createdby"] ?? "",
        modifiedby: json["modifiedby"] ?? "",
        // emailVerifiedAt: json["email_verified_at"] ?? "",
        photo: json["photo"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "full_name": fullName,
        "address": address,
        "phoneno": phoneno,
        "role_id": roleId,
        "department_id": departmentId,
        "location_id": locationId,
        "is_active": isActive,
        // "lastlogin": lastlogin,
        "verified": verified,
        "createdby": createdby,
        "modifiedby": modifiedby,
        // "email_verified_at": emailVerifiedAt,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
