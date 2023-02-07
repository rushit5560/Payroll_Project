// To parse this JSON data, do
//
//     final genralSettingModel = genralSettingModelFromJson(jsonString);

import 'dart:convert';

GenralSettingModel genralSettingModelFromJson(String str) =>
    GenralSettingModel.fromJson(json.decode(str));

String genralSettingModelToJson(GenralSettingModel data) =>
    json.encode(data.toJson());

class GenralSettingModel {
  GenralSettingModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final String data;

  factory GenralSettingModel.fromJson(Map<String, dynamic> json) =>
      GenralSettingModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: json["Data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data,
      };
}
