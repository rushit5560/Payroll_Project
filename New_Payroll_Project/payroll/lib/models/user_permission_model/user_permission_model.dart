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
    this.subadminview,
    this.subadminedit,
    this.companyadd,
    this.companyedit,
    this.companyview,
    this.departmentview,
    this.departmentadd,
    this.departmentedit,
    this.departmentdelete,
    this.locationview,
    this.locationadd,
    this.locationedit,
    this.locationdelete,
    this.employeeview,
    this.employeeadd,
    this.employeeedit,
    this.employeedelete,
    this.employeedocumentview,
    this.employeedocumentadd,
    this.employeedocumentdelete,
    this.employeedocumentdownload,
    this.payrollview,
    this.payrolladd,
    this.payrolldownload,
    this.payrolldelete,
    this.approvepaychecksview,
    this.approvepaychecksedit,
    this.approvepaychecksdelete,
    this.emailtemplateview,
    this.emailtemplateadd,
    this.emailtemplateedit,
    this.generalsettingview,
    this.generalsettingedit,
  });

  String? subadminview;
  String? subadminedit;
  String? companyadd;
  String? companyedit;
  String? companyview;
  String? departmentview;
  String? departmentadd;
  String? departmentedit;
  String? departmentdelete;
  String? locationview;
  String? locationadd;
  String? locationedit;
  String? locationdelete;
  String? employeeview;
  String? employeeadd;
  String? employeeedit;
  String? employeedelete;
  String? employeedocumentview;
  String? employeedocumentadd;
  String? employeedocumentdelete;
  String? employeedocumentdownload;
  String? payrollview;
  String? payrolladd;
  String? payrolldownload;
  String? payrolldelete;
  String? approvepaychecksview;
  String? approvepaychecksedit;
  String? approvepaychecksdelete;
  String? emailtemplateview;
  String? emailtemplateadd;
  String? emailtemplateedit;
  String? generalsettingview;
  String? generalsettingedit;

  factory PermissionData.fromJson(Map<String, dynamic> json) => PermissionData(
        subadminview: json["subadminview"],
        subadminedit: json["subadminedit"],
        companyadd: json["companyadd"],
        companyedit: json["companyedit"],
        companyview: json["companyview"],
        departmentview: json["departmentview"],
        departmentadd: json["departmentadd"],
        departmentedit: json["departmentedit"],
        departmentdelete: json["departmentdelete"],
        locationview: json["locationview"],
        locationadd: json["locationadd"],
        locationedit: json["locationedit"],
        locationdelete: json["locationdelete"],
        employeeview: json["employeeview"],
        employeeadd: json["employeeadd"],
        employeeedit: json["employeeedit"],
        employeedelete: json["employeedelete"],
        employeedocumentview: json["employeedocumentview"],
        employeedocumentadd: json["employeedocumentadd"],
        employeedocumentdelete: json["employeedocumentdelete"],
        employeedocumentdownload: json["employeedocumentdownload"],
        payrollview: json["payrollview"],
        payrolladd: json["payrolladd"],
        payrolldownload: json["payrolldownload"],
        payrolldelete: json["payrolldelete"],
        approvepaychecksview: json["approvepaychecksview"],
        approvepaychecksedit: json["approvepaychecksedit"],
        approvepaychecksdelete: json["approvepaychecksdelete"],
        emailtemplateview: json["emailtemplateview"],
        emailtemplateadd: json["emailtemplateadd"],
        emailtemplateedit: json["emailtemplateedit"],
        generalsettingview: json["generalsettingview"],
        generalsettingedit: json["generalsettingedit"],
      );

  Map<String, dynamic> toJson() => {
        "subadminview": subadminview,
        "subadminedit": subadminedit,
        "companyadd": companyadd,
        "companyedit": companyedit,
        "departmentview": departmentview,
        "departmentadd": departmentadd,
        "departmentedit": departmentedit,
        "departmentdelete": departmentdelete,
        "locationview": locationview,
        "locationadd": locationadd,
        "locationedit": locationedit,
        "locationdelete": locationdelete,
        "employeeview": employeeview,
        "employeeadd": employeeadd,
        "employeeedit": employeeedit,
        "employeedelete": employeedelete,
        "employeedocumentview": employeedocumentview,
        "employeedocumentadd": employeedocumentadd,
        "employeedocumentdelete": employeedocumentdelete,
        "employeedocumentdownload": employeedocumentdownload,
        "payrollview": payrollview,
        "payrolladd": payrolladd,
        "payrolldownload": payrolldownload,
        "approvepaychecksview": approvepaychecksview,
        "approvepaychecksedit": approvepaychecksedit,
        "approvepaychecksdelete": approvepaychecksdelete,
        "emailtemplateview": emailtemplateview,
        "emailtemplateadd": emailtemplateadd,
        "emailtemplateedit": emailtemplateedit,
        "generalsettingview": generalsettingview,
        "generalsettingedit": generalsettingedit,
      };
}

/*class PermissionData {
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
}*/
