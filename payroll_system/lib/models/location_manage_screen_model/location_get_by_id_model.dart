// To parse this JSON data, do
//
//     final locationGetByIdModel = locationGetByIdModelFromJson(jsonString);

import 'dart:convert';

LocationGetByIdModel locationGetByIdModelFromJson(String str) =>
    LocationGetByIdModel.fromJson(json.decode(str));

String locationGetByIdModelToJson(LocationGetByIdModel data) =>
    json.encode(data.toJson());

class LocationGetByIdModel {
  LocationGetByIdModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final LocationGetByIdData data;

  factory LocationGetByIdModel.fromJson(Map<String, dynamic> json) =>
      LocationGetByIdModel(
        success: json["success"],
        messege: json["messege"],
        data: LocationGetByIdData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data.toJson(),
      };
}

class LocationGetByIdData {
  LocationGetByIdData({
    required this.id,
    required this.locationName,
    required this.isActive,
    required this.createdby,
    // this.modifiedby,
    required this.companyid,
    // this.createdAt,
    // this.updatedAt,
  });

  final int id;
  final String locationName;
  final String isActive;
  final int createdby;
  // final dynamic modifiedby;
  final int companyid;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  factory LocationGetByIdData.fromJson(Map<String, dynamic> json) =>
      LocationGetByIdData(
        id: json["id"] ?? 0,
        locationName: json["location_name"] ?? "",
        isActive: json["is_active"] ?? "",
        createdby: json["createdby"] ?? 0,
        // modifiedby: json["modifiedby"],
        companyid: json["companyid"] ?? 0,
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_name": locationName,
        "is_active": isActive,
        "createdby": createdby,
        // "modifiedby": modifiedby,
        "companyid": companyid,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
