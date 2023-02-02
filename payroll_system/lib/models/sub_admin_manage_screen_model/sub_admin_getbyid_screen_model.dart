import 'dart:convert';

SubAdminGetByIdModel subAdminGetByIdModelFromJson(String str) =>
    SubAdminGetByIdModel.fromJson(json.decode(str));

String subAdminGetByIdModelToJson(SubAdminGetByIdModel data) =>
    json.encode(data.toJson());

class SubAdminGetByIdModel {
  SubAdminGetByIdModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final SubAdminGetByIdData data;

  factory SubAdminGetByIdModel.fromJson(Map<String, dynamic> json) =>
      SubAdminGetByIdModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: SubAdminGetByIdData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}

class SubAdminGetByIdData {
  SubAdminGetByIdData({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.address,
    required this.phoneno,
    // this.roleId,
    // this.departmentId,
    // this.locationId,
    required this.street,
    required this.town,
    required this.state,
    required this.city,
    required this.zipcode,
    // this.isActive,
    // this.lastlogin,
    // this.verified,
    // this.createdby,
    // this.modifiedby,
    // this.emailVerifiedAt,
    // this.photo,
    // this.employeeId,
    // this.createdAt,
    // this.updatedAt,
  });

  final int id;
  final String userName;
  final String email;
  final String fullName;
  final String address;
  final String phoneno;
  // final String roleId;
  // final dynamic departmentId;
  // final dynamic locationId;
  final String street;
  final String town;
  final String state;
  final String city;
  final String zipcode;
  // final String isActive;
  // final dynamic lastlogin;
  // final String verified;
  // final String createdby;
  // final String modifiedby;
  // final dynamic emailVerifiedAt;
  // final String photo;
  // final dynamic employeeId;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  factory SubAdminGetByIdData.fromJson(Map<String, dynamic> json) =>
      SubAdminGetByIdData(
        id: json["id"] ?? 0,
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        address: json["address"] ?? "",
        phoneno: json["phoneno"] ?? "",
        // roleId: json["role_id"],
        // departmentId: json["department_id"],
        // locationId: json["location_id"],
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zipcode: json["zipcode"] ?? "",
        // isActive: json["is_active"],
        // lastlogin: json["lastlogin"],
        // verified: json["verified"],
        // createdby: json["createdby"],
        // modifiedby: json["modifiedby"],
        // emailVerifiedAt: json["email_verified_at"],
        // photo: json["photo"],
        // employeeId: json["employee_id"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

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
  //     "street": street,
  //     "town": town,
  //     "state": state,
  //     "city": city,
  //     "zipcode": zipcode,
  //     "is_active": isActive,
  //     "lastlogin": lastlogin,
  //     "verified": verified,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "email_verified_at": emailVerifiedAt,
  //     "photo": photo,
  //     "employee_id": employeeId,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  // };
}
