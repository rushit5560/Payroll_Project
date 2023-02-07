// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final subadminListModel = subadminListModelFromJson(jsonString);

import 'dart:convert';

SubadminListModel subadminListModelFromJson(String str) =>
    SubadminListModel.fromJson(json.decode(str));

String subadminListModelToJson(SubadminListModel data) =>
    json.encode(data.toJson());

class SubadminListModel {
  SubadminListModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<SubadminListData> data;

  factory SubadminListModel.fromJson(Map<String, dynamic> json) =>
      SubadminListModel(
        success: json["success"],
        messege: json["messege"],
        data: List<SubadminListData>.from(
            json["Data"].map((x) => SubadminListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SubadminListData {
  SubadminListData({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.address,
    required this.phoneno,
    required this.roleId,
    required this.departmentId,
    required this.locationId,
    required this.street,
    required this.town,
    required this.state,
    required this.city,
    required this.zipcode,
    required this.isActive,
    required this.lastlogin,
    required this.verified,
    required this.createdby,
    required this.modifiedby,
    required this.emailVerifiedAt,
    required this.photo,
    required this.employeeId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String userName;
  final String email;
  final String fullName;
  final String address;
  final String phoneno;
  final int roleId;
  final String departmentId;
  final String locationId;
  final String street;
  final String town;
  final String state;
  final String city;
  final String zipcode;
  final String isActive;
  final String lastlogin;
  final String verified;
  final int createdby;
  final String modifiedby;
  final String emailVerifiedAt;
  final String photo;
  final String employeeId;
  final String createdAt;
  final String updatedAt;

  factory SubadminListData.fromJson(Map<String, dynamic> json) =>
      SubadminListData(
        id: json["id"] ?? 0,
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        address: json["address"] ?? "",
        phoneno: json["phoneno"] ?? "",
        roleId: json["role_id"] ?? 0,
        departmentId: json["department_id"] ?? "",
        locationId: json["location_id"] ?? "",
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zipcode: json["zipcode"] ?? "",
        isActive: json["is_active"] ?? "",
        lastlogin: json["lastlogin"] ?? "",
        verified: json["verified"] ?? "",
        createdby: json["createdby"] ?? 0,
        modifiedby: json["modifiedby"] ?? "",
        emailVerifiedAt: json["email_verified_at"] ?? "",
        photo: json["photo"] ?? "",
        employeeId: json["employee_id"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
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
