import 'dart:convert';

AllCompanyModel allCompanyModelFromJson(String str) =>
    AllCompanyModel.fromJson(json.decode(str));

String allCompanyModelToJson(AllCompanyModel data) =>
    json.encode(data.toJson());

class AllCompanyModel {
  AllCompanyModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  List<CompanyData> data;

  factory AllCompanyModel.fromJson(Map<String, dynamic> json) =>
      AllCompanyModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<CompanyData>.from(
            (json["Data"] ?? []).map((x) => CompanyData.fromJson(x ?? {}))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
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
    required this.isActive,
    // required this.lastlogin,
    required this.verified,
    required this.createdby,
    // required this.modifiedby,
    // required this.emailVerifiedAt,
    required this.photo,
    // required this.createdAt,
    // required this.updatedAt,
  });

  String id;
  String userName;
  String email;
  String fullName;
  String address;
  String phoneno;
  String roleId;
  String departmentId;
  String isActive;
  // dynamic lastlogin;
  String verified;
  String createdby;
  // dynamic modifiedby;
  // dynamic emailVerifiedAt;
  String photo;
  // DateTime createdAt;
  // dynamic updatedAt;

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        id: (json["id"] ?? 0).toString(),
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        address: json["address"] ?? "",
        phoneno: json["phoneno"] ?? "",
        roleId: (json["role_id"] ?? 0).toString(),
        departmentId: (json["department_id"] ?? "0").toString(),
        isActive: json["is_active"] ?? "",
        // lastlogin: json["lastlogin"],
        verified: json["verified"] ?? "",
        createdby: (json["createdby"] ?? 0).toString(),
        // modifiedby: json["modifiedby"],
        // emailVerifiedAt: json["email_verified_at"],
        photo: json["photo"] ?? "",
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: json["updated_at"],
      );

  /*Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "email": email,
    "full_name": fullName,
    "address": address,
    "phoneno": phoneno,
    "role_id": roleId,
    "department_id": departmentId,
    "is_active": isActive,
    "lastlogin": lastlogin,
    "verified": verified,
    "createdby": createdby,
    "modifiedby": modifiedby,
    "email_verified_at": emailVerifiedAt,
    "photo": photo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };*/
}
