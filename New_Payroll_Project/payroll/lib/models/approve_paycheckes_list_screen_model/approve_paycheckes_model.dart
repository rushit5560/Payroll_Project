import 'dart:convert';

ApprovalPermissionModel aboutDetailsModelFromJson(String str) =>
    ApprovalPermissionModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(ApprovalPermissionModel data) =>
    json.encode(data.toJson());

class ApprovalPermissionModel {
  ApprovalPermissionModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final EmployeeDeleteData data;

  factory ApprovalPermissionModel.fromJson(Map<String, dynamic> json) =>
      ApprovalPermissionModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        // data: EmployeeDeleteData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}
