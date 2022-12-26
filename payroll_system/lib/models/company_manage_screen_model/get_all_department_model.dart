import 'dart:convert';

AllDepartmentModel allDepartmentModelFromJson(String str) =>
    AllDepartmentModel.fromJson(json.decode(str));

String allDepartmentModelToJson(AllDepartmentModel data) =>
    json.encode(data.toJson());

class AllDepartmentModel {
  AllDepartmentModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  List<DepartmentData> data;

  factory AllDepartmentModel.fromJson(Map<String, dynamic> json) =>
      AllDepartmentModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<DepartmentData>.from(
            (json["Data"] ?? []).map((x) => DepartmentData.fromJson(x ?? {}))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DepartmentData {
  DepartmentData({
    required this.id,
    required this.departmentName,
    required this.isActive,
    required this.createdby,
    // required this.modifiedby,
    required this.companyid,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String departmentName;
  String isActive;
  int createdby;
  // int modifiedby;
  String companyid;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
        id: json["id"] ?? 0,
        departmentName: json["department_name"] ?? "",
        isActive: json["is_active"] ?? "",
        createdby: json["createdby"] ?? 0,
        // modifiedby: json["modifiedby"] == null ? null : json["modifiedby"],
        companyid: json["companyid"] ?? "",
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "is_active": isActive,
        "createdby": createdby,
        // "modifiedby": modifiedby == null ? null : modifiedby,
        "companyid": companyid,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
