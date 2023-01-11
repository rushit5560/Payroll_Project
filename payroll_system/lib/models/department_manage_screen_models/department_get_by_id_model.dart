import 'dart:convert';

DepartmentGetByIdModel departmentGetByIdModelFromJson(String str) => DepartmentGetByIdModel.fromJson(json.decode(str));

String departmentGetByIdModelToJson(DepartmentGetByIdModel data) => json.encode(data.toJson());

class DepartmentGetByIdModel {
  DepartmentGetByIdModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  Data data;

  factory DepartmentGetByIdModel.fromJson(Map<String, dynamic> json) => DepartmentGetByIdModel(
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
    required this.departmentName,
    required this.isActive,
    // required this.createdby,
    // required this.modifiedby,
    // required this.companyid,
    // required this.createdAt,
    // required this.updatedAt,
  });

  String id;
  String departmentName;
  String isActive;
  // int createdby;
  // dynamic modifiedby;
  // dynamic companyid;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? "0",
    departmentName: json["department_name"] ?? "",
    isActive: json["is_active"] ?? "",
    // createdby: json["createdby"],
    // modifiedby: json["modifiedby"],
    // companyid: json["companyid"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_name": departmentName,
    "is_active": isActive,
    // "createdby": createdby,
    // "modifiedby": modifiedby,
    // "companyid": companyid,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}
