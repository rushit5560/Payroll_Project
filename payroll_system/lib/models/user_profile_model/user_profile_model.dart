// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

import '../log_in_model.dart';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final UserData data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: UserData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data.toJson(),
      };
}
