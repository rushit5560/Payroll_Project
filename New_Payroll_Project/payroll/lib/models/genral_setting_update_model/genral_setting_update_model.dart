// To parse this JSON data, do
//
//     final dateFormatUpdateModel = dateFormatUpdateModelFromJson(jsonString);

import 'dart:convert';

DateFormatUpdateModel dateFormatUpdateModelFromJson(String str) =>
    DateFormatUpdateModel.fromJson(json.decode(str));

String dateFormatUpdateModelToJson(DateFormatUpdateModel data) =>
    json.encode(data.toJson());

class DateFormatUpdateModel {
  DateFormatUpdateModel({
    required this.success,
    required this.messege,
  });

  final bool success;
  final String messege;

  factory DateFormatUpdateModel.fromJson(Map<String, dynamic> json) =>
      DateFormatUpdateModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
      };
}
