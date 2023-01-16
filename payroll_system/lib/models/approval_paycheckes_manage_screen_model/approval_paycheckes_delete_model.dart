import 'dart:convert';

ApprovalDeleteModel aboutDetailsModelFromJson(String str) =>
    ApprovalDeleteModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(ApprovalDeleteModel data) =>
    json.encode(data.toJson());

class ApprovalDeleteModel {
  ApprovalDeleteModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final EmployeeDeleteData data;

  factory ApprovalDeleteModel.fromJson(Map<String, dynamic> json) =>
      ApprovalDeleteModel(
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
