import 'dart:convert';

CompanyGetByIdModel companyGetByIdModelFromJson(String str) => CompanyGetByIdModel.fromJson(json.decode(str));

String companyGetByIdModelToJson(CompanyGetByIdModel data) => json.encode(data.toJson());

class CompanyGetByIdModel {
  CompanyGetByIdModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  Data data;

  factory CompanyGetByIdModel.fromJson(Map<String, dynamic> json) => CompanyGetByIdModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
    data: Data.fromJson(json["Data"] ?? {}),
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
    // required this.createdby,
    // required this.modifiedby,
    // required this.emailVerifiedAt,
    required this.photo,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String userName;
  String email;
  String fullName;
  String address;
  String phoneno;
  int roleId;
  String departmentId;
  String isActive;
  // dynamic lastlogin;
  String verified;
  // int createdby;
  // int modifiedby;
  // dynamic emailVerifiedAt;
  String photo;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0,
    userName: json["user_name"] ?? "",
    email: json["email"] ?? "",
    fullName: json["full_name"] ?? "",
    address: json["address"] ?? "",
    phoneno: json["phoneno"] ?? "",
    roleId: json["role_id"] ?? 0,
    departmentId: json["department_id"] ?? "",
    isActive: json["is_active"] ?? "",
    // lastlogin: json["lastlogin"],
    verified: json["verified"] ?? "",
    // createdby: json["createdby"],
    // modifiedby: json["modifiedby"],
    // emailVerifiedAt: json["email_verified_at"],
    photo: json["photo"] ?? "",
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
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
    "is_active": isActive,
    // "lastlogin": lastlogin,
    "verified": verified,
    // "createdby": createdby,
    // "modifiedby": modifiedby,
    // "email_verified_at": emailVerifiedAt,
    "photo": photo,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}
