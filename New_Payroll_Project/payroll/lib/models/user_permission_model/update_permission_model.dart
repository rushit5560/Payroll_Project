import 'dart:convert';

UpdatePermissionModel updatePermissionModelFromJson(String str) => UpdatePermissionModel.fromJson(json.decode(str));

String updatePermissionModelToJson(UpdatePermissionModel data) => json.encode(data.toJson());

class UpdatePermissionModel {
  UpdatePermissionModel({
    required this.success,
    required this.messege,
  });

  bool success;
  String messege;

  factory UpdatePermissionModel.fromJson(Map<String, dynamic> json) => UpdatePermissionModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
  };
}
