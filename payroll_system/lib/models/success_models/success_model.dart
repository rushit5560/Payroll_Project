// To parse this JSON data, do
//
//     final successModel = successModelFromJson(jsonString);

import 'dart:convert';

SuccessModel successModelFromJson(String str) =>
    SuccessModel.fromJson(json.decode(str));

String successModelToJson(SuccessModel data) => json.encode(data.toJson());

class SuccessModel {
  SuccessModel({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
