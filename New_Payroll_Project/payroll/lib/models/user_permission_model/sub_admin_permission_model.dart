import 'dart:convert';

SubAdminPermissionModel subAdminPermissionModelFromJson(String str) => SubAdminPermissionModel.fromJson(json.decode(str));

String subAdminPermissionModelToJson(SubAdminPermissionModel data) => json.encode(data.toJson());

class SubAdminPermissionModel {
  SubAdminPermissionModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  Data data;

  factory SubAdminPermissionModel.fromJson(Map<String, dynamic> json) => SubAdminPermissionModel(
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
    this.companyadd,
    this.companyedit,
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
    this.approvepaychecksview,
    this.approvepaychecksedit,
    this.approvepaychecksdelete,
  });

  String? companyadd;
  String? companyedit;
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
  String? approvepaychecksview;
  String? approvepaychecksedit;
  String? approvepaychecksdelete;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyadd: json["companyadd"],
    companyedit: json["companyedit"],
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
    approvepaychecksview: json["approvepaychecksview"],
    approvepaychecksedit: json["approvepaychecksedit"],
    approvepaychecksdelete: json["approvepaychecksdelete"],
  );

  Map<String, dynamic> toJson() => {
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
  };
}
