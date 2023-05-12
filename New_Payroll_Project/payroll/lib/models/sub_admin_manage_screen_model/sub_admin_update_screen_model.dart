// To parse this JSON data, do
//
//     final subAdminUpdateModel = subAdminUpdateModelFromJson(jsonString);

import 'dart:convert';

SubAdminUpdateModel subAdminUpdateModelFromJson(String str) =>
    SubAdminUpdateModel.fromJson(json.decode(str));

String subAdminUpdateModelToJson(SubAdminUpdateModel data) =>
    json.encode(data.toJson());

class SubAdminUpdateModel {
  SubAdminUpdateModel({
    required this.success,
    required this.messege,
  });

  final bool success;
  final String messege;

  factory SubAdminUpdateModel.fromJson(Map<String, dynamic> json) =>
      SubAdminUpdateModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
      };
}
