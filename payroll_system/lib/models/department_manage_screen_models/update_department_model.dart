import 'dart:convert';

UpdateDepartmentModel updateDepartmentModelFromJson(String str) => UpdateDepartmentModel.fromJson(json.decode(str));

String updateDepartmentModelToJson(UpdateDepartmentModel data) => json.encode(data.toJson());

class UpdateDepartmentModel {
  UpdateDepartmentModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  bool data;

  factory UpdateDepartmentModel.fromJson(Map<String, dynamic> json) => UpdateDepartmentModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
    data: json["Data"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
    "Data": data,
  };
}
