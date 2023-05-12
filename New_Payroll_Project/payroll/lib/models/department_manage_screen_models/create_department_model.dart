import 'dart:convert';

CreateDepartmentModel createDepartmentModelFromJson(String str) => CreateDepartmentModel.fromJson(json.decode(str));

String createDepartmentModelToJson(CreateDepartmentModel data) => json.encode(data.toJson());

class CreateDepartmentModel {
  CreateDepartmentModel({
    required this.success,
    required this.messege,
    required this.error,
    // required this.data,
  });

  bool success;
  String messege;
  Error error;
  // Data data;

  factory CreateDepartmentModel.fromJson(Map<String, dynamic> json) => CreateDepartmentModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
    error: Error.fromJson(json["error"] ?? {}),
    // data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
    // "Data": data.toJson(),
  };
}

class Error {
  Error({
    required this.departmentName,
  });

  List<String> departmentName;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    departmentName: List<String>.from((json["department_name"] ?? []).map((x) => x ?? "")),
  );

  Map<String, dynamic> toJson() => {
    "department_name": List<dynamic>.from(departmentName.map((x) => x)),
  };
}


// class Data {
//   Data({
//     this.departmentName,
//     this.createdby,
//     this.isActive,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });
//
//   String departmentName;
//   String createdby;
//   String isActive;
//   DateTime updatedAt;
//   DateTime createdAt;
//   int id;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     departmentName: json["department_name"],
//     createdby: json["createdby"],
//     isActive: json["is_active"],
//     updatedAt: DateTime.parse(json["updated_at"]),
//     createdAt: DateTime.parse(json["created_at"]),
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "department_name": departmentName,
//     "createdby": createdby,
//     "is_active": isActive,
//     "updated_at": updatedAt.toIso8601String(),
//     "created_at": createdAt.toIso8601String(),
//     "id": id,
//   };
// }
