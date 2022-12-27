// To parse this JSON data, do
//
//     final categorizeFavProductsModel = categorizeFavProductsModelFromJson(jsonString);

import 'dart:convert';

UserPermissionModel categorizeFavProductsModelFromJson(String str) =>
    UserPermissionModel.fromJson(json.decode(str));

String categorizeFavProductsModelToJson(UserPermissionModel data) =>
    json.encode(data.toJson());

class UserPermissionModel {
  UserPermissionModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final PermissionData data;

  factory UserPermissionModel.fromJson(Map<String, dynamic> json) =>
      UserPermissionModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: PermissionData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data.toJson(),
      };
}

class PermissionData {
  PermissionData({
    this.roleadd,
    this.roleedit,
    this.roleview,
    this.companyadd,
    this.roledelete,
    this.companyedit,
    this.companyview,
    this.employeeadd,
    this.locationadd,
    this.employeeedit,
    this.employeeview,
    this.locationedit,
    this.locationview,
    this.companydelete,
    this.departmentadd,
    this.departmentedit,
    this.departmentview,
    this.employeedelete,
    this.locationdelete,
    this.departmentdelete,
  });

  final String? roleadd;
  final String? roleedit;
  final String? roleview;
  final String? companyadd;
  final String? roledelete;
  final String? companyedit;
  final String? companyview;
  final String? employeeadd;
  final String? locationadd;
  final String? employeeedit;
  final String? employeeview;
  final String? locationedit;
  final String? locationview;
  final String? companydelete;
  final String? departmentadd;
  final String? departmentedit;
  final String? departmentview;
  final String? employeedelete;
  final String? locationdelete;
  final String? departmentdelete;

  factory PermissionData.fromJson(Map<String, dynamic> json) => PermissionData(
        roleadd: json["roleadd"],
        roleedit: json["roleedit"],
        roleview: json["roleview"],
        companyadd: json["companyadd"],
        roledelete: json["roledelete"],
        companyedit: json["companyedit"],
        companyview: json["companyview"],
        employeeadd: json["employeeadd"],
        locationadd: json["locationadd"],
        employeeedit: json["employeeedit"],
        employeeview: json["employeeview"],
        locationedit: json["locationedit"],
        locationview: json["locationview"],
        companydelete: json["companydelete"],
        departmentadd: json["departmentadd"],
        departmentedit: json["departmentedit"],
        departmentview: json["departmentview"],
        employeedelete: json["employeedelete"],
        locationdelete: json["locationdelete"],
        departmentdelete: json["departmentdelete"],
      );

  Map<String, dynamic> toJson() => {
        "roleadd": roleadd,
        "roleedit": roleedit,
        "roleview": roleview,
        "companyadd": companyadd,
        "roledelete": roledelete,
        "companyedit": companyedit,
        "companyview": companyview,
        "employeeadd": employeeadd,
        "locationadd": locationadd,
        "employeeedit": employeeedit,
        "employeeview": employeeview,
        "locationedit": locationedit,
        "locationview": locationview,
        "companydelete": companydelete,
        "departmentadd": departmentadd,
        "departmentedit": departmentedit,
        "departmentview": departmentview,
        "employeedelete": employeedelete,
        "locationdelete": locationdelete,
        "departmentdelete": departmentdelete,
      };
}
