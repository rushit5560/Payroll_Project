// To parse this JSON data, do
//
//     final updateCompanyModel = updateCompanyModelFromJson(jsonString);

import 'dart:convert';

UpdateCompanyModel updateCompanyModelFromJson(String str) => UpdateCompanyModel.fromJson(json.decode(str));

String updateCompanyModelToJson(UpdateCompanyModel data) => json.encode(data.toJson());

class UpdateCompanyModel {
  UpdateCompanyModel({
    required this.success,
    required this.messege,
  });

  final bool success;
  final String messege;

  factory UpdateCompanyModel.fromJson(Map<String, dynamic> json) => UpdateCompanyModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
  };
}
