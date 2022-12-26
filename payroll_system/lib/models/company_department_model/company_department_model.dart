// To parse this JSON data, do
//
//     final aboutDetailsModel = aboutDetailsModelFromJson(jsonString);

import 'dart:convert';

CompanyDepartmentModel aboutDetailsModelFromJson(String str) =>
    CompanyDepartmentModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(CompanyDepartmentModel data) =>
    json.encode(data.toJson());

class CompanyDepartmentModel {
  CompanyDepartmentModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<CompanyDepartmentData> data;

  factory CompanyDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CompanyDepartmentModel(
        success: json["success"],
        messege: json["messege"],
        data: List<CompanyDepartmentData>.from(
            json["Data"].map((x) => CompanyDepartmentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompanyDepartmentData {
  CompanyDepartmentData({
    required this.id,
    required this.departmentName,
    // this.isActive,
    // this.createdby,
    // this.modifiedby,
    // this.companyid,
    // this.createdAt,
    // this.updatedAt,
  });

  final int id;
  final String departmentName;
  // final String isActive;
  // final int createdby;
  // final dynamic modifiedby;
  // final dynamic companyid;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  factory CompanyDepartmentData.fromJson(Map<String, dynamic> json) =>
      CompanyDepartmentData(
        id: json["id"],
        departmentName: json["department_name"],
        // isActive: json["is_active"],
        // createdby: json["createdby"],
        // modifiedby: json["modifiedby"],
        // companyid: json["companyid"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "department_name": departmentName,
  //     "is_active": isActive,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "companyid": companyid,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  // };
}
