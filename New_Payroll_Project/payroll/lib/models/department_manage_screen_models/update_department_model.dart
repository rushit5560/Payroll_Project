import 'dart:convert';

UpdateDepartmentModel updateDepartmentModelFromJson(String str) =>
    UpdateDepartmentModel.fromJson(json.decode(str));

String updateDepartmentModelToJson(UpdateDepartmentModel data) =>
    json.encode(data.toJson());

class UpdateDepartmentModel {
  UpdateDepartmentModel({
    required this.success,
    required this.messege,
    required this.data,
    required this.error,
  });

  bool success;
  String messege;
  bool data;
  Error? error;

  factory UpdateDepartmentModel.fromJson(Map<String, dynamic> json) =>
      UpdateDepartmentModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: json["Data"] ?? false,
        error: Error.fromJson(json["error"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data,
      };
}

class Error {
  Error({
    required this.departmentName,
  });

  List<String> departmentName;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        departmentName: List<String>.from(
            (json["department_name"] ?? []).map((x) => x ?? "")),
      );

  Map<String, dynamic> toJson() => {
        "department_name": List<dynamic>.from(departmentName.map((x) => x)),
      };
}
